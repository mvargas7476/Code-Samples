## Story
This puzzle and my solutions came out of a conversation with my uncle about
programming puzzles I could use to sharpen my skills. That's how I found
[Tom's Data Onion](https://www.tomdalling.com/toms-data-onion/).

## Description of the puzzle
As the website describes, the puzzle has multiple nested layers. Solving each
layer reveals a new set of directions and a new challenge for the layer beneath
it. The goal is to peel all the layers and find the core within.

## Project outline
After solving each layer, I split its directions and payload into their own
folders (`Layer_Directions/` and `Payloads/`). The small programs that solve
each layer live in the main folder, and each one is named for the layer it
solves.

I'm not including The Core here — the whole point of Tom's Data Onion is to
reach it yourself — but the code I used to get there is included.

## Layers
| Layer | Challenge |
|-------|-----------|
| 0 | Payload is encoded with ASCII85 |
| 1 | Flip every second bit, then rotate each byte one place to the right |
| 2 | The 8th bit of each byte is a parity bit — validate and strip it |
| 3 | Decrypt the payload via XOR with a recovered key |
| 4 | Parse the IPv4 + UDP protocol layers |
| 5 | AES decryption |
| 6 | Build a small virtual machine / emulator |

_Uses the Python standard library (plus a crypto library for the AES layer)._
