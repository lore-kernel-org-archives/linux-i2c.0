From: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Fri, 8 Jul 2011 16:48:50 -0500 (CDT)
Message-ID: <21511805.221.1310161730242.JavaMail.root@zmail.rockbochs.com>
References: <20110707182315.6e28f62a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110707182315.6e28f62a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

----- Original Message -----
> Your binary->hex is correct, and the command as well, but the chip did
> not like the write for some reason. You should look at the kernel logs
> when it failed, there may be a hint. You could also just retry to
> check
> if this was maybe a transient error.
> 
> To test the reliability of the SMBus you could dump the whole register
> map:
> # i2cdump -y -r 0x00-0x22 0 0x19
> and look for XX's.
> 

I'm seeing a *lot* of 'XX's present. Here are ten samples:

root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX 00 XX 55 XX XX XX XX ff XX XX    XXXXXX.XUXXXX.XX
10: 3f XX XX XX 00 XX XX XX XX XX ff XX XX XX XX XX    ?XXX.XXXXX.XXXXX
20: 95 92 XX                                           ??X
root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX 55 XX XX XX XX ff XX XX    XXXXXXXXUXXXX.XX
10: XX XX 00 XX XX XX XX XX XX XX XX XX XX XX XX XX    XX.XXXXXXXXXXXXX
20: XX 92 XX                                           X?X
root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 9f 00 XX XX XX XX XX XX XX XX XX XX XX XX XX XX    ?.XXXXXXXXXXXXXX
10: XX XX XX 3f XX XX XX XX XX ff XX XX XX XX XX XX    XXX?XXXXX.XXXXXX
20: XX 92 XX                                           X?X
root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX 00 00 XX XX XX XX XX XX XX XX    XXXXXX..XXXXXXXX
10: XX XX XX XX XX XX 00 XX XX XX XX XX XX ff ff ff    XXXXXX.XXXXXX...
20: XX XX XX                                           XXX
root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX 00 ff XX XX XX XX XX XX XX XX XX ff XX XX    XX..XXXXXXXXX.XX
10: XX XX 00 XX XX XX XX XX XX XX XX ff ff XX ff XX    XX.XXXXXXXX..X.X
20: XX XX XX                                           XXX
root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX 00 XX 00 XX XX XX XX XX XX XX XX XX XX XX    XX.X.XXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX ff XX XX XX XX XX XX    XXXXXXXXX.XXXXXX
20: XX 92 XX                                           X?X
root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX 00 00 XX XX XX XX XX ff XX XX    XXXXXX..XXXXX.XX
10: XX XX 00 XX XX XX XX XX XX XX XX ff XX ff XX XX    XX.XXXXXXXX.X.XX
20: 95 XX XX                                           ?XX
root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 9f XX XX XX XX XX XX XX 55 XX XX ff XX XX XX XX    ?XXXXXXXUXX.XXXX
10: XX 00 XX XX XX XX XX XX XX ff XX XX XX XX XX XX    X.XXXXXXX.XXXXXX
20: XX XX 00                                           XX.
root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX 00 XX XX XX XX XX XX XX ff XX XX XX    XXXX.XXXXXXX.XXX
10: XX XX 00 XX 00 XX 00 XX XX XX XX XX XX ff XX XX    XX.X.X.XXXXXX.XX
20: XX XX XX                                           XXX
root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX 9e XX XX ff XX XX XX    XXXXXXXXX?XX.XXX
10: XX 00 00 XX XX XX XX XX XX XX ff ff XX XX XX ff    X..XXXXXXX..XXX.
20: XX XX XX                                           XXX

What does this mean? Unstable SMBus?

--Tim
