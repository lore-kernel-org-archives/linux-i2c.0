From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/8] i2c: img-scb: enable fencing for all versions of
 the ip
Date: Tue, 28 Jul 2015 10:38:08 +0100
Message-ID: <55B74D80.9010901@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com> <1437997641-32575-2-git-send-email-sifan.naeem@imgtec.com> <20150727202055.GG18890@jhogan-linux.le.imgtec.org> <A0E307549471DA4DBAF2DE2DE6CBFB7E4966D862@hhmail02.hh.imgtec.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="n0PiUeccq01jwLd0HvEHhsJb6W4NvSCDp"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966D862@hhmail02.hh.imgtec.org>
Sender: stable-owner@vger.kernel.org
To: Sifan Naeem <Sifan.Naeem@imgtec.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

--n0PiUeccq01jwLd0HvEHhsJb6W4NvSCDp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/07/15 10:26, Sifan Naeem wrote:
> Hi James,
>=20
>> -----Original Message-----
>> From: James Hogan
>> Sent: 27 July 2015 21:21
>> To: Sifan Naeem
>> Cc: Wolfram Sang; linux-i2c@vger.kernel.org; Stable kernel (v3.19+)
>> Subject: Re: [PATCH 1/8] i2c: img-scb: enable fencing for all versions=
 of the ip
>>
>> Hi Sifan,
>>
>> On Mon, Jul 27, 2015 at 12:47:14PM +0100, Sifan Naeem wrote:
>>> The code to read from the master read fifo, and write to the master
>>> write fifo, checks a bit in an SCB register before every byte to
>>> ensure that the fifo is not full (write fifo) or empty (read fifo).
>>> Due to clock domain crossing inside the SCB block the updated value o=
f
>>> this bit is only visible after 2 cycles.
>>>
>>> The scb_wr_rd_fence() function does 2 dummy writes (to the read-only
>>> revision register), and it's called before reading from or writing to=

>>> the fifos to ensure that subsequent reads of the fifo status bits do
>>> not read stale values.
>>>
>>> As the 2 dummy writes are required in all versions of the ip, the
>>> version check is dropped.
>>
>> Is it anticipated that a future version of the hardware will probably =
resolve
>> the clock domain crossing issue? If so fine, but if not its probably w=
orth
>> removing need_wr_rd_fence.
>>
> Yes, it's expected to be fixed in the future, albeit not in the near fu=
ture.

Okay, no problem then.

>=20
>>>
>>> Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB
>>> driver")
>>
>> I believe 12 digits of SHA1 is recommended now, to avoid collisions. I=
 suggest
>> doing this:
>> $ git config --global core.abbrev 12
>>
> Should I send a new patch with 12 digit SHA1?

I need to review the other patches anyway (sorry i've been slow to look
through them properly).

>=20
>>> Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
>>> Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
>>
>> That's a fairly non-conventional way to specify stable versions. The
>> recommended way to Cc stable according to
>> Documentation/stable_kernel_rules.txt is more like this:
>> Cc: <stable@vger.kernel.org> # 3.19.x-
>>
>=20
> I go this error when doing that way:
>=20
> (body) Adding cc: Sifan Naeem <sifan.naeem@imgtec.com> from line 'Signe=
d-off-by: Sifan Naeem <sifan.naeem@imgtec.com>'
> (body) Adding cc: <stable@vger.kernel.org> # 4.1 from line 'Cc: <stable=
@vger.kernel.org> # 4.1'
> Use of uninitialized value $cc in string eq at /usr/lib/git-core/git-se=
nd-email line 983.
> Use of uninitialized value $cc in quotemeta at /usr/lib/git-core/git-se=
nd-email line 983.
> W: unable to extract a valid address from: <stable@vger.kernel.org> # 4=
=2E1
> W: unable to extract a valid address from: <stable@vger.kernel.org> # 4=
=2E1

Sounds like you're using an old version of git. Something similar is
described here:
http://comments.gmane.org/gmane.comp.version-control.git/210042

If the warning can be ignored, you can always add stable back to cc list
with --cc=3Dstable@vger.kernel.org.

Cheers
James

>=20
>> Patch looks fine though
>>
>> Acked-by: James Hogan <james.hogan@imgtec.com>
>>
> Thanks,
> Sifan
>=20
>> Thanks
>> James
>>
>>> ---
>>>  drivers/i2c/busses/i2c-img-scb.c |    8 ++------
>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-img-scb.c
>>> b/drivers/i2c/busses/i2c-img-scb.c
>>> index 00ffd66..5c3c615 100644
>>> --- a/drivers/i2c/busses/i2c-img-scb.c
>>> +++ b/drivers/i2c/busses/i2c-img-scb.c
>>> @@ -278,8 +278,6 @@
>>>  #define ISR_COMPLETE(err)	(ISR_COMPLETE_M | (ISR_STATUS_M &
>> (err)))
>>>  #define ISR_FATAL(err)		(ISR_COMPLETE(err) | ISR_FATAL_M)
>>>
>>> -#define REL_SOC_IP_SCB_2_2_1	0x00020201
>>> -
>>>  enum img_i2c_mode {
>>>  	MODE_INACTIVE,
>>>  	MODE_RAW,
>>> @@ -1120,10 +1118,8 @@ static int img_i2c_init(struct img_i2c *i2c)
>>>  		return -EINVAL;
>>>  	}
>>>
>>> -	if (rev =3D=3D REL_SOC_IP_SCB_2_2_1) {
>>> -		i2c->need_wr_rd_fence =3D true;
>>> -		dev_info(i2c->adap.dev.parent, "fence quirk enabled");
>>> -	}
>>> +	/* Fencing enabled by default. */
>>> +	i2c->need_wr_rd_fence =3D true;
>>>
>>>  	bitrate_khz =3D i2c->bitrate / 1000;
>>>  	clk_khz =3D clk_get_rate(i2c->scb_clk) / 1000;
>>> --
>>> 1.7.9.5
>>>


--n0PiUeccq01jwLd0HvEHhsJb6W4NvSCDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVt02AAAoJEGwLaZPeOHZ6fjQP/Az8K3s28ZHlexzkkPyA/tRq
qk3akwPLmRteZHhWQPp0dXaSf3I2XiJj8a4KZiyDDq9bNeOaY937zG/ObDXvt4PB
aYpclGmjhqhdfS+mV7/8Oc9RAwGGDDu+4mLAkL3TnSb/IB943BQDcI1JXG7mZeWG
Gfb2VQd+D4w6rN6Qli++VpokZe2ZGmqjEbKrJ3WBLsrTJcXzDx6cbu2+FE78OF69
5Ou04nQ2EKshEzUB5L9myyZ+F+ZLyKEkwVq/sgSsrpEWi3Ihb2aRdiRtHvSsMMXn
fjYMzvnIDw4nLvNn6vFSNpLOdhDPRZ+fdR5xvectQqDi6cj6vdsyfWlnP4vg+G0K
m9rp6h602TOG3kXpckAdg/2DMF9TVwB0NMZX+IKNXr106V/bIO95cZ/L4jIY061M
DYIYKNlaUfp+Ef8F5KBmsWFia4uOXU8s5WxJs+UJRpIRwgoy7L1hjBFDlh7ET1NJ
LxU2s4BR/Gno7dumtaoBiF5h6mRI/MAgSPy3cxyfXjOExGWLLP3Dv6VpYtYuB3oa
/u4GTdok0XPWcNX0+Wl0iMWkOb4nguuVp8gMNN3MtWX1lvbJSC/P2VuRikuf0GFN
ZVYoFfrohFyveS4pCwREza9sGZpkNtbltcbSZqHW5NToOCtTaB8OOC6WugobdCtZ
2EKZTyxV+BhKIIDCNZna
=4Eze
-----END PGP SIGNATURE-----

--n0PiUeccq01jwLd0HvEHhsJb6W4NvSCDp--
