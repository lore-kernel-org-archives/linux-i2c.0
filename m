From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
Date: Tue, 7 Apr 2009 22:16:41 -0700
Message-ID: <fa686aa40904072216m64b4fd83q9b52c89ae40cae11@mail.gmail.com>
References: <20090407082052.477328750@denx.de> <53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53B42D49-C040-442E-8448-7BC3190220A5-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 7, 2009 at 10:11 PM, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>=
 wrote:
>
> On Apr 7, 2009, at 3:20 AM, Wolfgang Grandegger wrote:
>
>> This patch series makes the I2C bus speed configurable by using the
>> I2C node property "clock-frequency". If the property is not defined,
>> the old fixed clock settings will be used for backward compatibility=
=2E
>> The property "fsl,preserve-clocking" allows to inherit the settings
>> from the bootloader. Furthermore, it does some cleanup and uses the
>> new bindings for the Socrates board:
>>
>> =A0i2c: i2c-mpc: various coding style fixes
>> =A0i2c: i2c-mpc: use dev based printout function
>> =A0i2c: i2c-mpc: make I2C bus speed configurable
>
> It looks like Ben picked up these patches.
>
>> =A0powerpc: i2c-mpc: document new FSL I2C bindings and cleanup
>> =A0powerpc/85xx: i2c-mpc: use new I2C bindings for the Socates board
>
> I would have preferred these two go via me, but it looks like the boa=
rd one
> got picked up by Ben. =A0I'll deal with the doc/binding update.

hrummm.  As I mentioned in my reply, I'm not convinced that the board
one is the right thing in this case.  I would have preferred it to be
deferred.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
