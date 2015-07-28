From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 5/8] i2c: img-scb: reset interrupts in img_i2c_soft_reset
Date: Tue, 28 Jul 2015 12:51:00 +0100
Message-ID: <55B76CA4.1040705@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com> <1437997641-32575-6-git-send-email-sifan.naeem@imgtec.com> <55B76910.8030006@imgtec.com> <A0E307549471DA4DBAF2DE2DE6CBFB7E4966D8FA@hhmail02.hh.imgtec.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="nqgsn4kVnW4oIIwXLeP6tTqb73feSSt3V"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966D8FA@hhmail02.hh.imgtec.org>
Sender: stable-owner@vger.kernel.org
To: Sifan Naeem <Sifan.Naeem@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

--nqgsn4kVnW4oIIwXLeP6tTqb73feSSt3V
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 28/07/15 12:46, Sifan Naeem wrote:
> Hi James,
>=20
>> -----Original Message-----
>> From: James Hogan
>> Sent: 28 July 2015 12:36
>> To: Sifan Naeem; Wolfram Sang; linux-i2c@vger.kernel.org
>> Cc: Stable kernel (v3.19+)
>> Subject: Re: [PATCH 5/8] i2c: img-scb: reset interrupts in img_i2c_sof=
t_reset
>>
>> On 27/07/15 12:47, Sifan Naeem wrote:
>>> Reset interrupt enable register and clear any generated interrupts to=

>>> make sure of a clean slate after a soft reset. Not doing so might
>>> leave unhandle line status or generated interrupts which can cause
>>> issues when handling new transfers.
>>
>> That already happens after the call to img_i2c_soft_reset, you've just=
 moved
>> it to while the clock is off and the block is in soft reset. So are yo=
u saying its
>> important for interrupts and the various event bits to be clear before=
 taking it
>> out of reset and enabling the clock? TBH I'm confused how they could d=
o any
>> harm.
>>
> In " [PATCH 7/8] i2c: img-scb: improve transaction complete handle "
> img_i2c_soft_reset is added to img_i2c_complete_transaction, this will
> be useful in this scenario, not necessarily for when initialising the
> block.

Okay, in that case you should clarify in the commit message that it is
in preparation for later patches, rather than fixing an existing problem.=


Cheers
James

>=20
> Thanks
> Sifan
>> Cheers
>> James
>>
>>>
>>> Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB
>>> driver")
>>> Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
>>> Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
>>> ---
>>>  drivers/i2c/busses/i2c-img-scb.c |   26 ++++++++++++++------------
>>>  1 file changed, 14 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-img-scb.c
>>> b/drivers/i2c/busses/i2c-img-scb.c
>>> index 51a5be8..653f9bd 100644
>>> --- a/drivers/i2c/busses/i2c-img-scb.c
>>> +++ b/drivers/i2c/busses/i2c-img-scb.c
>>> @@ -507,8 +507,22 @@ static void img_i2c_soft_reset(struct img_i2c
>>> *i2c)  {
>>>  	i2c->t_halt =3D false;
>>>  	img_i2c_writel(i2c, SCB_CONTROL_REG, 0);
>>> +
>>> +	/* Disable all interrupts */
>>> +	img_i2c_writel(i2c, SCB_INT_MASK_REG, 0);
>>> +
>>> +	/* Clear all interrupts */
>>> +	img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
>>> +
>>> +	/* Clear the scb_line_status events */
>>> +	img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
>>> +
>>>  	img_i2c_writel(i2c, SCB_CONTROL_REG,
>>>  		       SCB_CONTROL_CLK_ENABLE |
>> SCB_CONTROL_SOFT_RESET);
>>> +
>>> +	/* Enable interrupts */
>>> +	img_i2c_switch_mode(i2c, MODE_INACTIVE);
>>> +	img_i2c_writel(i2c, SCB_INT_MASK_REG, i2c->int_enable);
>>>  }
>>>
>>>  /* enable or release transaction halt for control of repeated starts=

>>> */ @@ -1242,18 +1256,6 @@ static int img_i2c_init(struct img_i2c *i2c=
)
>>>  	/* Take module out of soft reset and enable clocks */
>>>  	img_i2c_soft_reset(i2c);
>>>
>>> -	/* Disable all interrupts */
>>> -	img_i2c_writel(i2c, SCB_INT_MASK_REG, 0);
>>> -
>>> -	/* Clear all interrupts */
>>> -	img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
>>> -
>>> -	/* Clear the scb_line_status events */
>>> -	img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
>>> -
>>> -	/* Enable interrupts */
>>> -	img_i2c_writel(i2c, SCB_INT_MASK_REG, i2c->int_enable);
>>> -
>>>  	/* Perform a synchronous sequence to reset the bus */
>>>  	ret =3D img_i2c_reset_bus(i2c);
>>>
>>>
>=20


--nqgsn4kVnW4oIIwXLeP6tTqb73feSSt3V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVt2ykAAoJEGwLaZPeOHZ6y4cQAKWyXUuWgLx4mwyBhV5OL8KD
K8xKObrdBHjQW8GtIZjY3VehMsqXioOEO5KfhTa5cDknjBXbAWdOzBjED3CRtmmZ
e8AAFxCI92or/tvAvv/FoLCpIiQ43/CKALaKqRC+xNpzrvjZ0CADWAJvSV3twHRL
qMyUW8rO/pDzHlWviaO9u3IgenE4ZF2fwmp9dMKq4qagVRbr5GNNwWtrfoEFEk9g
y6sWqHg1xny9jgYyeFl8vx6BZWp4b0OjPLFZCX80fo7hgmxiFk8LcDPAy4fbbqNG
AI4RDeNoql05d8PtYAjEEWSxvQWzG5BYUBDvd3EdSgwRST6AYaQldbKmHfFiyl/n
Knxwre4Y0TdqnqwJeIlE3WHekXXPrDtXHA+mxNpszsSXxRw9B2f0g91nJRrRzEdn
jCs1E9VCEG8jIE3a1Ra77rl9AjJtKedrNLK+jKDRSfzDOcay9mp9Jnn4SxEfYltP
Wj8N+Wl3jkeVtZ00OxiLGil9OGYPePTs1zCC3Pb4q3TSpNjnmbvq240Nz0xAKmB7
Kd85uos1qvWhYk/4UdiPXyGGvHkZu9hk/kP7WLZupotC14UNiBspkLubCo1v4z5V
QpPK2nJB2waAD8oLHVEyCJ3N47H8sX39ezJxKKfKuzDANLSJT0UE2qt0sLssWClT
4wZCghXue+CVY02EaTJY
=lA67
-----END PGP SIGNATURE-----

--nqgsn4kVnW4oIIwXLeP6tTqb73feSSt3V--
