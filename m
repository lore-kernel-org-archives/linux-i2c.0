From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [Linux-kernel] [PATCH] i2c: i2c-gpio: fix some of gpio sleep
 issues
Date: Wed, 22 Apr 2015 11:43:32 +0300
Message-ID: <55375F34.10104@codethink.co.uk>
References: <1426593869-8724-1-git-send-email-ben.dooks@codethink.co.uk> <20150327154609.GD27238@katana> <55375E6B.9050405@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55375E6B.9050405-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 22/04/15 11:40, Ben Dooks wrote:
> On 27/03/15 17:46, Wolfram Sang wrote:
>> On Tue, Mar 17, 2015 at 12:04:29PM +0000, Ben Dooks wrote:
>>> The i2c-gpio driver can be used in systems where the GPIO
>>> itself is provided by a GPIO driver that may be sleeping (for
>>> example, SPI or USB). In this case, it is preferable to use
>>> the _cansleep() variants of the GPIO code.
>>> 
>>> We can only fix this up for the case where the i2c-gpio 
>>> implementation provides open-drain outputs as there are no 
>>> gpio_direction_xxx_cansleep() provided.
>>> 
>>> This removes the issues on the customer system with the
>>> console constantly showing the following warning:
>>> 
>>> WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:2389 
>>> gpiod_set_raw_value
> 
>> ??? It will silence a warning but will totally break the timing
>> in case sleeping is needed? I'd think the warning is very
>> suitable.
> 
> This basically causes our system to fail to boot in any suitable
> time.
> 
> The problem is that the i2c bus is on the end of an SPI bus which
> means that the identification EEPROM tests and other items read
> from it will run through a gpio chip that is marked as 'can
> sleep'.
> 
> I don't have the exact times, but I got bored after the first
> thirty seconds of these log messages and immediately patched them
> out of the kernel.

Would a probe time warn and then doing the same change be ok?

- -- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN180AAoJEMuhVOkVU3uzxSEH/jwcYKeGH8oz9k3aFfg6qHVf
u57lz2q2v2ajAhL6vA5zFOqBvJmzJnoy45uvhbZeZNV9C+F104a+Yk2Z+QIqJh5t
uQ5kZ5WCQ8QX/tS5cWEhq76zHvfooLa6Qw0WbuAKn36fA8n9Xedhuu4ozW9ofhZf
+dpTJQ3eK5RhaNyhSxFtXrfts4TgAHFI4UluUA9lyZ6acAWRDB3WWNt2sbol9os2
xrD5F2818etjsqWslJEw3MgTLHZFfswKAhYRiRjbasGpoLL0YGvfLsC+cnJrrVVy
N4OBsFs8KiXMk3MsuN1IxMa0fWvKhzbmMHmM74flp2tmStJ2iJbP6ta9U2Su3oU=
=A7M6
-----END PGP SIGNATURE-----
