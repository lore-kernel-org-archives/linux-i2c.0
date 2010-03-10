From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using algo-bit in another i2c algo
Date: Wed, 10 Mar 2010 17:56:28 -0500
Message-ID: <a728f9f91003101456p294eb590i98b340152cd740e6@mail.gmail.com>
References: <a728f9f91001111413t1a733e0rbc0352ddd2d9de7c@mail.gmail.com>
	 <20100310104401.57fc43b2@hyperion.delvare>
	 <a728f9f91003101116l422374d2vceb1e5dddfdf44d8@mail.gmail.com>
	 <20100310224936.0d4f8a65@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100310224936.0d4f8a65-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 10, 2010 at 4:49 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> On Wed, 10 Mar 2010 14:16:18 -0500, Alex Deucher wrote:
>> I tested the second patch with a trivial patch to the radeon drm:
>>
>> --- a/drivers/gpu/drm/radeon/radeon_i2c.c
>> +++ b/drivers/gpu/drm/radeon/radeon_i2c.c
>> @@ -892,9 +892,9 @@ struct radeon_i2c_chan *radeon_i2c_create(struct
>> drm_device *dev,
>> =A0 =A0 =A0 =A0 =A0* make this, 2 jiffies is a lot more reliable */
>> =A0 =A0 =A0 =A0 i2c->algo.radeon.bit_data.timeout =3D 2;
>> =A0 =A0 =A0 =A0 i2c->algo.radeon.bit_data.data =3D i2c;
>> - =A0 =A0 =A0 ret =3D i2c_bit_add_bus(&i2c->algo.radeon.bit_adapter)=
;
>> + =A0 =A0 =A0 ret =3D i2c_bit_prepare_bus(&i2c->algo.radeon.bit_adap=
ter);
>> =A0 =A0 =A0 =A0 if (ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRM_ERROR("Failed to register internal=
 bit i2c %s\n", name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRM_ERROR("Failed to prepare internal =
bit i2c %s\n", name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free;
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 /* set the radeon i2c adapter */
>>
>> However, just calling i2c_bit_prepare_bus does not appear to be
>> enough. as I get the following oops:
>> (...)
>
> Hmm, sorry, I have probably not been clear about the intent of
> i2c_bit_prepare_bus(). It does _not_ give you a usable i2c_adapter. T=
he
> actual initialization happens in i2c_register_adapter(), in i2c-core.
> What it gives you is a usable i2c _algorithm_. That is, you can call
> bit_adapter.algo->master_xfer(), presumably from within your actual
> (registered) adapter's master_xfer() function.
>
> Now, I have to admit that it is pretty confusing that you call a
> "prepare" function on an i2c_adapter and you can't use it. And lookin=
g
> a bit more into it... Even calling bit_adapter.algo->master_xfer()
> assumes an initialized i2c_adapter, at least for error messages. So m=
y
> proposal was probably not such a good idea, at least not with the
> current i2c-algo-bit implementation, and probably not without a big
> rework of the i2c algorithm structure itself: at the moment, i2c
> algorithms really assume that they have an i2c_adapter associated _an=
d_
> that this i2c_adapter has a device associated.
>
> Maybe we could move the core of i2c-algo-bit to a library so that it =
is
> easier to reuse. But that would be a lot more work, so we will only d=
o
> this there is a clear benefit. At this point, it seems cheaper to
> pursue the first option (pre- and post-xfer hooks) if that works for
> you.

Yes, the first option is working well so far.

Alex
