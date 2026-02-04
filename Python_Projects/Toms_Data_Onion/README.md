## Story
This puzzle and solutions came from a conversation with my uncle.
In the conversation we talked about different programming puzzles
that I could use to improve my skills.

From there I learned of Tom's Data Onion (https://www.tomdalling.com/toms-data-onion/)

## Description of the Puzzle
As the website describes, you have a puzzle with multiple layers in it.
Each time that you solve a layer, you are given a new set of direcations
with a new challenge to solve the next layer. The main idea is to peal
all of the layers adn to find the core within

## Project Outline
After solving each layer and getting the next set of directions and its
respective payload, I separate the payload and the direction into their
respective folders. As for the little programs to solve each layer, they
are in the main folder and they just tell you which challenge each project
will solve.

I will no be putting The Core in here since the idea behind Tom's Data Onion
is to get to the core by oneself. But I will still uplopad the code I used to get there 

## Layer Quick Description
Layer       Description
0           Payload is encrypted with ascii85
1           You are suppose to flip each second bite and then rotate them all to the right
2           The 8th bit in each byte is the parity bit. Follow some more checks based on the parity bit
3           Decrypting the file by using XOR with a discovered key
4           IPv4 and UDP Protocol Decription
5           AES Decrypter
6           Create an Emulator