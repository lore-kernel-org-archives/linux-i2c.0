From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-core.ko renamed to i2ccore.ko
Date: Fri, 19 Sep 2014 16:28:02 +0800
Message-ID: <541BE912.6060905@intel.com>
References: <1411042678.7338.20.camel@chaos.site> <20140918125825.GR10854@lahna.fi.intel.com> <20140918150954.GA4420@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140918150954.GA4420@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B409=E6=9C=8818=E6=97=A5 23:10, Wolfram Sang wrote:
> On Thu, Sep 18, 2014 at 03:58:57PM +0300, Mika Westerberg wrote:
>> On Thu, Sep 18, 2014 at 02:17:58PM +0200, Jean Delvare wrote:
>>> Hi guys,
>>>
>>> Sorry for jumping in a bit late, but given that I did not get invol=
ved
>>> in the discussions that led to this decision, better late than neve=
r.
>>>
>>> I almost had an heart attack when noticing that module i2c-core.ko =
has
>>> suddenly been renamed to i2ccore.ko without an hyphen.
>>>
>>> Renaming kernel modules is almost always wrong, in particular subsy=
stem
>>> core modules. Such renames have an impact at various levels. We jus=
t had
>>> to change a configuration file in the openSUSE Factory kernel to ad=
just
>>> that change, and this is how I noticed it. But there can be several
>>> other issues, including mkinitrd or equivalent tools, as well as
>>> documentation. The extra work and confusion is a high price to pay,=
 and
>>> it can easily be avoided.
>>
>> I understand completely your point and I guess this was rather
>> inadvertent change.
>=20
> Yes. Thanks for pointing out, Jean!
>=20
>>
>>> So I am kindly asking that you revert this name change before kerne=
l
>>> v3.17 final. Rename source files if you really have to, git makes i=
t
>>> easy. Or merge the i2c-acpi.c code into i2c-core.c with ifdefs. Or
>>> whatever. Just don't rename i2c-core.ko, please.
>>
>> My vote goes for merging i2c-acpi.c back to i2c-core.c with #ifdefs.
>>
>> Tianyu, Wolfram, comments?
>=20
> Agreed.
>=20

How about including i2c-acpi.c in the i2c-core.c directly if ACPI is
selected?


--=20
Best regards
Tianyu Lan
