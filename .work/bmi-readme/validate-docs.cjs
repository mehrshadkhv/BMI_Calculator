const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const {execFileSync} = require('node:child_process');
const root = path.resolve(__dirname, '..', '..');
const results = [];
function check(ok, message) { if (!ok) throw new Error(message); results.push(message); }
const en = fs.readFileSync(path.join(root, 'README.md'), 'utf8');
const fa = fs.readFileSync(path.join(root, 'README.fa.md'), 'utf8');
const switcher = '[English](README.md) | [فارسی](README.fa.md)';
check(en.startsWith(switcher + '\n'), 'English language switcher is the first line.');
check(fa.startsWith('<div dir="rtl" align="right">\n\n' + switcher + '\n'), 'Persian document has an outer RTL wrapper with its language switcher at the top.');
check(fa.trimEnd().endsWith('</div>'), 'Persian RTL document is closed.');
for (const [name, text] of [['README.md', en], ['README.fa.md', fa]]) {
  check(!text.includes('\uFFFD'), name + ': valid text without replacement characters.');
  const images = [...text.matchAll(/<img\s+src="([^"]+)"\s+width="200"\s+alt="([^"]+)"\s*\/>/g)];
  check(images.length === 4, name + ': all four screenshots have 200px widths and descriptive alt text.');
  for (const image of images) check(fs.existsSync(path.join(root, decodeURIComponent(image[1]))), name + ': image exists: ' + image[1]);
  for (const match of text.matchAll(/\]\(([^\)]+)\)/g)) {
    const target = match[1];
    if (!/^https?:\/\//.test(target) && !target.startsWith('#')) check(fs.existsSync(path.join(root, decodeURIComponent(target))), name + ': relative link exists: ' + target);
  }
  const fences = text.match(/^```/gm) || [];
  check(fences.length % 2 === 0, name + ': code fences are paired.');
  check(text.includes('https://github.com/mehrshadkhv/BMI_Calculator.git'), name + ': clone URL matches the local Git remote.');
}
const divs = [];
let fenced = false;
let codeBlocks = 0;
for (const line of fa.split('\n')) {
  if (line.startsWith('```')) {
    if (!fenced) { check(divs.at(-1) === 'ltr', 'Persian code block ' + (++codeBlocks) + ' is inside an LTR wrapper.'); fenced = true; } else fenced = false;
    continue;
  }
  if (fenced) continue;
  const open = line.match(/^<div dir="(rtl|ltr)" align="(right|left)">$/);
  if (open) divs.push(open[1]);
  if (line === '</div>') { check(divs.length > 0, 'Persian wrapper closing tag is balanced.'); divs.pop(); }
}
check(!fenced && divs.length === 0, 'All Persian code blocks and direction wrappers are balanced.');
const git = (...args) => execFileSync('git', ['-c', 'safe.directory=' + root.replaceAll('\\', '/'), ...args], {cwd:root, encoding:'utf8'});
const platforms = ['android','ios','web','linux','macos','windows'];
for (const platform of platforms) {
  const file = platform + '/nested/deeper/example.txt';
  check(git('check-attr', 'linguist-vendored', '--', file).trim().endsWith(': true'), 'Recursive platform exclusion works: ' + platform);
}
for (const file of ['model.g.dart','lib/models/model.g.dart','lib/models/deep/model.freezed.dart']) {
  check(git('check-attr', 'linguist-generated', '--', file).trim().endsWith(': true'), 'Generated Dart exclusion works: ' + file);
}
check(git('check-attr', 'linguist-vendored', 'linguist-generated', '--', 'lib/main.dart').split('\n').filter(Boolean).every(x => x.endsWith(': unspecified')), 'Handwritten Dart remains included.');
const originalHashes = {
  'lib/main.dart': '9035C6B685A199FB85CE8A194C2BED5FB90C819F752AAB23D0BE81D1B803E5EC',
  'assets/screenshots/main-screen.png': '75BF38B973765A006230516222609DA2E663618B0AE3FBE49AB98A2005A6C6D3',
  'assets/screenshots/Malnutrition.png': '7B930EF12A97B3AEC5FEC0048533152A2ECD231E24D7C30372D17198B1D3F46E',
  'assets/screenshots/Normal weight.png': 'D3D98A7F32A92A450357D37BCE92AED950499A27D62DD91ED307CFF0DF49C782',
  'assets/screenshots/Overweight.png': 'EF688E2233483BE388B4176112256E7857C1412DCA50034A23F3563F4931AD41'
};
for (const [file, hash] of Object.entries(originalHashes)) {
  const actual = crypto.createHash('sha256').update(fs.readFileSync(path.join(root, file))).digest('hex').toUpperCase();
  check(actual === hash, 'Existing user file is unchanged: ' + file);
}
process.stdout.write(results.join('\n') + '\n\nPASS: ' + results.length + ' documentation checks.\n');
