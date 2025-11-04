import wabt from 'wabt';
import { readFile, writeFile } from 'fs/promises';

const wabtModule = await wabt();
const watSource = await readFile('crt.wat', 'utf8');
const module = wabtModule.parseWat('crt.wat', watSource);
const binary = module.toBinary({});
await writeFile('crt.wasm', binary.buffer);
module.destroy();
console.log('Built crt.wasm');
