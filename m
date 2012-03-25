From: "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Registering i2c devices with Device Tree
Date: Sun, 25 Mar 2012 14:49:45 -0400
Message-ID: <CAKON4OyhkvMHbXZsFCt9yEHPZSM16mG9f9HKnp7cNS9Zn+cNJw@mail.gmail.com>
References: <CAKON4Oy5hSpDS4mpJHL-Nk95+9MMSwUqE6TXnvH2wn2XaNA68Q@mail.gmail.com>
	<20120325204150.20d3dcdb@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120325204150.20d3dcdb-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Mar 25, 2012 at 2:41 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> On Sun, 25 Mar 2012 13:29:51 -0400, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> All of the OF aware i2c bus drivers need to do:
>> =A0 =A0 =A0 of_i2c_register_devices(&alg_data->adapter);
>>
>> Can this be moved to the common core code?
>
> I seem to recall that someone once proposed to move the call to
> i2c-core, but the dependencies and #ifdef mess that resulted made me
> reject it. That doesn't mean it can't be done, but just moving the ca=
ll
> is not the way.

You could make the #ifdef go away by putting an #ifdef into
<linux/of_i2c.h> to stub out the call when CONFIG_OF is not defined.

I don't think the dependencies are as much of a problem anymore. I'm
bringing up a new ARM platform and didn't have any problem adding it.
I just noticed that is was duplicated in a dozen bus drivers.

>
> --
> Jean Delvare



--=20
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
