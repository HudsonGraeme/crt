import { watch } from 'chokidar';
import wabt from 'wabt';
import { readFile, writeFile } from 'fs/promises';

const wabtModule = await wabt();

const watcher = watch('*.wat');

watcher.on('change', async (path) => {
  const wasm = path.replace('.wat', '.wasm');
  console.log(`Compiling ${path} -> ${wasm}`);
  try {
    const watSource = await readFile(path, 'utf8');
    const module = wabtModule.parseWat(path, watSource);
    const binary = module.toBinary({});
    await writeFile(wasm, binary.buffer);
    module.destroy();
    console.log(`Compiled ${wasm}`);
  } catch (error) {
    console.error(error.message);
  }
});

console.log('Watching *.wat files...');
