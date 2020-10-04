# Clifford Crypto

Ruby library for cryptographic tools in Ruby.

## Requirements

This code requires Ruby installed on your system. There are [several options for downloading and installing Ruby](https://www.ruby-lang.org/en/downloads/ "Download Ruby").

This project uses only Ruby standard libraries, so once you have Ruby installed (version 2.6.3 and greater), you have everything required to run the code. We tested our implementation on Mac OSX version 10.13.6 with ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin17].

## Usage

### Running tests

Once Ruby is installed on your machine, from the command line and in the root directory of the project, run the tests to check the code with the following command:

`$ rake`

You should get a result similiar to the following:

```console
Run options: --seed 9109

# Running:

...........

Finished in 5.316182s, 2.0692 runs/s, 9.0290 assertions/s.

11 runs, 48 assertions, 0 failures, 0 errors, 0 skips
```

### Ruby Interactive Shell

You can also run code from the Ruby Interactive Shell (IRB). From the project's root directory, execute the following command on the terminal:

`$ irb`

You will see the IRB's prompt. Next, command snippets for specific cases that can be executed on IRB.

### Working with multivectors

Require the file the will boot the entire project on IRB:

`> require './boot'`

Creating a multivector:

`> m = Clifford::Multivector3D.new [2,3,4,5,6,7,8,9]`

which returns

`=> 2e0 + 3e1 + 4e2 + 5e3 + 6e12 + 7e13 + 8e23 + 9e123`

Clifford conjugation:

`> m.clifford_conjugation`

or

`> m.cc`

`=> 2e0 + -3e1 + -4e2 + -5e3 + -6e12 + -7e13 + -8e23 + 9e123`

Reverse:

`> m.reverse`

`=> 2e0 + 3e1 + 4e2 + 5e3 + -6e12 + -7e13 + -8e23 + -9e123`

Amplitude squared:

`> m.amplitude_squared`

`=> 22e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + -16e123`

Rationalize:

`> m.rationalize`

`=> 740e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

Inverse:

`> m.inverse`

`=> -5/37e0 + 31/370e1 + -10/37e2 + -7/370e3 + -53/185e12 + -9/74e13 + -56/185e23 + 23/74e123`

Geometric product:

`> m.geometric_product(m.inverse)` or `>> m.gp(m.inverse)`

`=> 1e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

`> m.gp(m)`

`=> -176e0 + -132e1 + 142e2 + -88e3 + 114e12 + -44e13 + 86e23 + 88e123`

Addition:

`> m.plus(m)`

`=> 4e0 + 6e1 + 8e2 + 10e3 + 12e12 + 14e13 + 16e23 + 18e123`

Subtraction:

`> m.minus(m)`

`=> 0e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

Scalar division:

`> m.scalar_div(2)`

`=> 1e0 + 3/2e1 + 2e2 + 5/2e3 + 3e12 + 7/2e13 + 4e23 + 9/2e123`

Scalar multiplication:

`> m.scalar_mul(2)`

`=> 4e0 + 6e1 + 8e2 + 10e3 + 12e12 + 14e13 + 16e23 + 18e123`

All multivectors M in Cl(3,0) can be decomposed as in M = Z + F. Obtaining Z:

`> m.z`

`=> 2e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 9e123`

Obtaining F:

`> m.f`

`=> 0e0 + 3e1 + 4e2 + 5e3 + 6e12 + 7e13 + 8e23 + 0e123`

Obtaining F squared:

`> m.f2`

`=> -99e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 52e123`

Obtaining the eigenvalues a multivector:

`> m.eigenvalues`

`=> [(4.5323662175072155+19.26707741568027i), (-0.5323662175072155-1.2670774156802675i)]`

### Working with multivectors and modular arithmetic

In order to create a mulltivector `m` with modulus `257` (a prime number, so it is guaranteed that all numbers less then 257 has a multiplicative inverse with respect to 257), we execute:

`> m = Clifford::Multivector3DMod.new [2,3,4,5,6,7,8,9], 257`

`=> 2e0 + 3e1 + 4e2 + 5e3 + 6e12 + 7e13 + 8e23 + 9e123`

All the multivector functions previously showed are reduced the given modulus. Here are few examples:

`> m.gp(m)`       

`=> 81e0 + 125e1 + 142e2 + 169e3 + 114e12 + 213e13 + 86e23 + 88e123`

`m.scalar_div(2)`

`=> 1e0 + 130e1 + 2e2 + 131e3 + 3e12 + 132e13 + 4e23 + 133e123`

`m.inverse`

`=> 111e0 + 255e1 + 222e2 + 216e3 + 40e12 + 177e13 + 115e23 + 233e123`

### Tools

Random number:

`> bits = 16`

`> Clifford::Tools.random_number(bits)`

`=> 33756`

Random prime:

`> Clifford::Tools.random_prime(bits)`

`=> 49499`

Next prime:

`> Clifford::Tools.next_prime(19222)`

`=> 19231`

Number to multivector:

`> n = 34985`

`> b = 8`

`> Clifford::Tools.number_to_multivector(n,b)`

`=> 169e0 + 136e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

`n = 18169120281480229197`

`> m = Clifford::Tools.number_to_multivector(n,b)`

`> Clifford::Tools.multivector_to_number(m,b)`

`=> 18169120281480229197`

Number to multivector with modulus:

`> b = 16`

`> q = Clifford::Tools.next_prime(2**b)`

`=> 65537`

`n = 155255861474355364696744344743093116292`

`> m = Clifford::Tools.number_to_multivector_mod(n,b,q)`

`=> 40324e0 + 22750e1 + 2092e2 + 50819e3 + 18412e12 + 50885e13 + 12534e23 + 29901e123`

String to multivector:

`> s = "Clifford"`

`> m = Clifford::Tools.string_to_multivector(s,b)`

`=> 100e0 + 114e1 + 111e2 + 102e3 + 102e12 + 105e13 + 108e23 + 67e123`

String to multivector with modulus:

`> s = "Clifford geometric algebra"`

`> m = Clifford::Tools.string_to_multivector_mod(s,b,q)`

`=> 29281e0 + 25954e1 + 27751e2 + 8289e3 + 26979e12 + 29810e13 + 28005e23 + 25967e123`

Random multivector:

`> m = Clifford::Tools.generate_random_multivector(b)`

`=> 44981e0 + 50764e1 + 52829e2 + 39937e3 + 50099e12 + 58945e13 + 36262e23 + 56362e123`

Random multivector with modulus:

`> m = Clifford::Tools.generate_random_multivector_mod(b,q)`

`=> 60703e0 + 43439e1 + 52290e2 + 37782e3 + 59922e12 + 33501e13 + 40135e23 + 57261e12`

Random non-invertible multivector:

`> m = Clifford::Tools.generate_random_multivector_mod_ni(b,q)`

`=> 49726e0 + 35271e1 + 50769e2 + 49726e3 + 31036e12 + 35271e13 + 50769e23 + 31036e123`

Number to random multivector with modulus:

`> m = Clifford::Tools.number_to_random_multivector_mod(n,b,q)`

`=> 41072e0 + 33223e1 + 42126e2 + 1274e3 + 62091e12 + 52417e13 + 58782e23 + 49587e123`

### Key Exchange Protocol

Let `l` (lambda) be `l=256`. Alice generates her private and public identification:

`> party1 = Clifford::Party.new(l,1)`

`=> #<Clifford::Party:0x00007fa0fc91e250 @l=256, @i=1, @b=32, @q=4294967311, @pr=4082888592e0 + 2970916432e1 + 3614131966e2 + 3835973787e3 + 3459588553e12 + 2819237312e13 + 3920843807e23 + 4038494032e123, @pu=3844552889e0 + 2856422503e1 + 2647812175e2 + 3988708505e3 + 4023339242e12 + 3519489537e13 + 2334011332e23 + 4085777762e123>`

Bob generates his identification:

`> party2 = Clifford::Party.new(l,2)`

`=> #<Clifford::Party:0x00007fa0fc906b00 @l=256, @i=2, @b=32, @q=4294967311, @pr=4217437264e0 + 2919379184e1 + 3758189817e2 + 3218512332e3 + 3899930951e12 + 2451174901e13 + 2739387602e23 + 3651382765e123, @pu=3504377994e0 + 2154318858e1 + 2990407714e2 + 4109525169e3 + 2404838778e12 + 2241414388e13 + 4216596680e23 + 3548652449e123>`

Alice computes the public communication identifier between her and Bob:

`> party1.set_public_communication_identifier(party2.pu)`

`=> 4210356305e0 + 4089303194e1 + 14255468e2 + 529900161e3 + 2901154698e12 + 2157868276e13 + 322773276e23 + 2455086363e123`

Bob computes the public communication identifier between him and Alice:

`> party2.set_public_communication_identifier(party1.pu)`

`=> 4210356305e0 + 4089303194e1 + 14255468e2 + 529900161e3 + 2901154698e12 + 2157868276e13 + 322773276e23 + 2455086363e123`

Alice computes her subkey:

`> party1.generate_sub_key`

`=> 18112708e0 + 68617604e1 + 2673310093e2 + 1016875217e3 + 1995411623e12 + 1569928174e13 + 347823432e23 + 1123480071e123`

Bob computes his subkey:

`> party2.generate_sub_key`

`=> 1160333216e0 + 1302916347e1 + 2392935595e2 + 3572898714e3 + 857440264e12 + 550001767e13 + 3937478375e23 + 2290586975e123`

Alice computes the shated secret key by processing Bob's subkey:

`> party1.exchange(party2.s)`

`=> 1508356315e0 + 3213603373e1 + 3757510450e2 + 2495228342e3 + 1118860303e12 + 1019561553e13 + 1508301431e23 + 2912177267e123`

Bob computes the shared secret key by processing Alice's subkey:

`> party2.exchange(party1.s)`

`=> 1508356315e0 + 3213603373e1 + 3757510450e2 + 2495228342e3 + 1118860303e12 + 1019561553e13 + 1508301431e23 + 2912177267e123`

Alice and Bob now shares the same secret key:

`> party1.k`

`=> 1508356315e0 + 3213603373e1 + 3757510450e2 + 2495228342e3 + 1118860303e12 + 1019561553e13 + 1508301431e23 + 2912177267e123`

`> party2.k`

`=> 1508356315e0 + 3213603373e1 + 3757510450e2 + 2495228342e3 + 1118860303e12 + 1019561553e13 + 1508301431e23 + 2912177267e123`

### Edge Computing Communication Simulation

Let `l` (lambda) be `l=256`.

Initiate the server:

`> server = Clifford::EdgeServer.new(l)`

`=> #<Clifford::EdgeServer:0x00007fa0fd0a2cd8 @l=256, @adb=[], @data=[2432875889e0 + 3398644683e1 + 3177574809e2 + 3127474435e3 + 2213199892e12 + 2990439562e13 + 2965090958e23 + 2409744597e123, 3399894085e0 + 3359522646e1 + 2968491911e2 + 2486413191e3 + 3698432485e12 + 3830596169e13 + 2338284137e23 + 3688954750e123, 2925428101e0 + 2878252239e1 + 2171908922e2 + 2978275610e3 + 3123973552e12 + 2336192367e13 + 2164944363e23 + 3343126797e123, 3429580229e0 + 2749926600e1 + 2173909838e2 + 4224153541e3 + 4207097895e12 + 3873964047e13 + 3107259472e23 + 4195818052e123, 4227402580e0 + 2336621835e1 + 2314282052e2 + 2355411878e3 + 2254483697e12 + 2333459783e13 + 3707702393e23 + 3422014906e123, 3131451880e0 + 2999212870e1 + 4251293590e2 + 4151653557e3 + 2652719859e12 + 2784093882e13 + 2258766432e23 + 3449041157e123, 4168737979e0 + 4208827959e1 + 4190304648e2 + 3933551184e3 + 3430813711e12 + 3888011618e13 + 3078610763e23 + 2289171039e123, 3883367289e0 + 2338542177e1 + 2446101734e2 + 3401989627e3 + 3936608260e12 + 2294082743e13 + 2448391638e23 + 2637761792e123]>`

Initiate the device:

`device = Clifford::EdgeDevice.new(l)`

`=> #<Clifford::EdgeDevice:0x00007fa0fd0fd750 @l=256, @party=#<Clifford::Party:0x00007fa0fd0fd138 @l=256, @i=2, @b=32, @q=4294967311, @pr=2958965187e0 + 2354858175e1 + 3681931934e2 + 3368863719e3 + 3609578854e12 + 4171261320e13 + 3030469317e23 + 2913205108e123, @pu=3187110577e0 + 3386054633e1 + 4028910751e2 + 3389217251e3 + 2436110671e12 + 3215888003e13 + 3967274834e23 + 3898096089e123>>`

Initiate an access request from the device to the server:

`> pu_1,s_1 = server.initiate_request(device.party.pu)`

`=> [3609741775e0 + 4033861436e1 + 2472252217e2 + 3383726549e3 + 2789401950e12 + 3574581422e13 + 4088312480e23 + 2917855981e123, 3689229509e0 + 2433374628e1 + 2558452138e2 + 2824421460e3 + 755547577e12 + 3020689430e13 + 2448557229e23 + 1399424609e123]`

Exchange the server's subkey with the device so both can share the same secret key for a one time access:

`> pu_2,s_2 = device.exchange(pu_1,s_1)`

`=> [3187110577e0 + 3386054633e1 + 4028910751e2 + 3389217251e3 + 2436110671e12 + 3215888003e13 + 3967274834e23 + 3898096089e123, 1487110752e0 + 1407463346e1 + 764696177e2 + 1913394294e3 + 1903366650e12 + 3438111503e13 + 3142483320e23 + 267123246e123]`

The server registers the device as an authorized device:

`> server.register(pu_2,s_2)`

The device requests acesss to an object with ID = 3. The server processes the request and, if the request is valid, responds with an encrypted object:

`> c = server.request_data(pu_2,3)`

`=> 2244895724e0 + 1214249872e1 + 3596991337e2 + 3751755225e3 + 2529704933e12 + 1974934899e13 + 534947787e23 + 2910596580e123`

The device receives and decrypts the encrypted object:

`> d = device.receive_data(c)`

`=> 3429580229e0 + 2749926600e1 + 2173909838e2 + 4224153541e3 + 4207097895e12 + 3873964047e13 + 3107259472e23 + 4195818052e123`

And we can check that `d` is the object with index `3` from the server data:

`> server.data[3]`

`=> 3429580229e0 + 2749926600e1 + 2173909838e2 + 4224153541e3 + 4207097895e12 + 3873964047e13 + 3107259472e23 + 4195818052e123`

### Hash Algorithm

Let `s = "Clifford geometric algebra"`

Compute the hash value of `s` as follows:

`> Clifford::Hash.new(256,s)`

`=> fe97a5f31fc86359cea5ff77de2740bd2016b1af7ea0f5f31283a3e31bf7666`

### Private-Key Encryption Scheme

Let `l = 256` and `m_10`, the number we want to encrypt be `> m_10 = 784`. We instantiate the `crypto` object as follows:

`> crypto = Clifford::Crypto.new l`

`=> #<Clifford::Crypto:0x00007fe9641a12d8 @l=256, @b=32, @q=4294967311, @k=3443407236e0 + 2462326299e1 + 2430435949e2 + 2214413904e3 + 4101620105e12 + 3186336471e13 + 4036216482e23 + 2484149767e123, @r=20>`

Encrypt `m_10`:

`> c = crypto.encrypt(m_10)`

`=> 1928814270e0 + 2450327391e1 + 742280819e2 + 3744386726e3 + 1432075849e12 + 1021926058e13 + 106172601e23 + 806413551e123`

Decrypt c:

`> crypto.decrypt(c)`

`=> 784`
