From: Christian Ruppert <christian.ruppert@alitech.com>
Subject: Re: [PATCH] i2c: designware: Suppress error message if platform_get_irq()
 returns -EPROBE_DEFER
Date: Tue, 03 Mar 2015 18:46:53 +0100
Message-ID: <54F5F38D.5050309@alitech.com>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com> <54F5E120.3090705@alitech.com> <1425400650.17965.53.camel@synopsys.com> <OF441D1D4D.39476C28-ONC1257DFD.005BE73C-C1257DFD.005C7908@alitech.com> <20150303172145.GA7076@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150303172145.GA7076@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "christian.ruppert@abilis.com" <christian.ruppert@abilis.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
List-Id: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2015-03-03 18:21, Wolfram Sang wrote:
> 
>> which omit this type of messages completely. Andy's proposal of 
>> centralising this looks like a very good solution here (and on
>> top of that removes many useless strings from the kernel
>> binary).
> 
> I am all for centralizing printouts. I recommended this at my ELCE
> talk last year, too. However, you need to keep in mind that irqs
> are sometimes optional and you don't want error messages for those
> irqs. IMO worthwhile, but not a low hanging fruit...

There is a lot of truth in that. Thus the initial dev_dbg() suggestion
to go half way. I still think that Andy's proposal (or a variation
thereof to catch the optional irqs case) should be the ultimate goal
but I agree that this is more than a quick patch and that it's
probably way out of scope here.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJU9fONAAoJENOBSR1q+OdQLh0P/3f9NIBGyvpr3ao+UVhiW26f
8ikcd1lHezjGZuILPgsobb4bpePwyV0IYLoqediGtwOSlbe6IlxC5DTzwlcJhUe5
BDtker32yPTohA8uc27PFlnZ3secJ3xngmF43QwsP4waQxdLsufQ85YQ1/P4SXhQ
gkxZpE1J1T4jVshtrf4lWlMJ3okdN2n/aFILRkNPCGc5QV9FjAMDwzYJLhBJw8wj
0Xe0X6zflgLlbUGfIeUIPoS7Stn9JtLZt/ltRAPBfFdKwBLUWOvmqGWl5XBcgzRi
UCEEefQl7T/H5HXOEdUyLuCFNsa7rMLEGX8HVSpqb1516dMM4L4vQomISKQyW5ED
SHLaCwzIsQTLdaY4gfNdKjJQMkuZSktz5zG8k3SRAR1PSqzNn7isUcc12HmoyRUd
2lONuN79r3z2iM591FofG69uC64RAJc5DHBj9gHbyvPwp48SMOQThO2vUunZvDoZ
E9rfux3Dj0txpxeh4GqGUjtDXmIhcLm9uXMYQ2UBMH/vaz3adWcX3rH76MLTIZCS
a0ilv+7Jr8VDgJcik2hiFIsSURSZqKSub6bXefvUYc8jOscREa0SnBQvGT3xkl+p
n57+5d+lWpkT4a5LSVRqkhhAtG+g/Ti09YOfhR2Z3C2xvWxM7VyVbxY69UDPXW5Z
sBDHtNkqCZUcx5wdkPec
=cvA7
-----END PGP SIGNATURE-----
