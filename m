From: "xinhui.pan" <xinhuix.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-designware-pcidrv: fix the incorrect return of idle
 callback
Date: Wed, 29 Jan 2014 15:35:28 +0800
Message-ID: <52E8AF40.6000103@intel.com>
References: <52E744AC.2050606@intel.com> <20140128183035.GC20789@katana> <52E86175.6010300@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52E86175.6010300-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bo.he-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



=E4=BA=8E 2014=E5=B9=B401=E6=9C=8829=E6=97=A5 10:03, xinhui.pan =E5=86=99=
=E9=81=93:
>=20
>> On Tue, Jan 28, 2014 at 01:48:28PM +0800, xinhui.pan wrote:
>>> From: "xinhui.pan" <xinhuix.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>>
>>> i2c_dw_pci_runtime_idle should return -EBUSY rather than zero if it=
 do success.
>>
>> I don't understand...
>>
> Sorry for my poor English.=20
> Even if i2c_dw_pci_runtime_idle succeed ,it should return -EBUSY.
>>> Otherwise rpm_idle will call pm_suspend again and that may cause pm=
_schedule_suspend delay invalidate.
>>> =09
>>> Signed-off-by: bo.he <bo.he-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> Signed-off-by: xinhui.pan <xinhuix.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/i2c/busses/i2c-designware-pcidrv.c |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i=
2c/busses/i2c-designware-pcidrv.c
>>> index f6ed06c..96e81f6 100644
>>> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
>>> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
>>> @@ -190,8 +190,8 @@ static int i2c_dw_pci_runtime_idle(struct devic=
e *dev)
>>>  	int err =3D pm_schedule_suspend(dev, 500);
>>>  	dev_dbg(dev, "runtime_idle called\n");
>>> =20
>>> -	if (err !=3D 0)
>>> -		return 0;
>>> +	if (err)
>>> +		return err;
>>>  	return -EBUSY;
>>
>> ... it does return EBUSY when pm_schedule_suspend() succeeds? It onl=
y
>> returns 0 if it does not succeed (for which I don't know if this is =
an
>> apropriate behaviour). Mika?
>>
hi ,
I found one sentence in /Documentation/power/runtime_pm.txt
 "If there is no idle callback, or if the callback returns 0,=20
then the PM core will attempt to carry out a runtime suspend of the dev=
ice,
also respecting devices configured for autosuspend."=20
  so is this a right way to prevent this?
Br. xinhui
>>>  }
>>> =20
>>> --=20
>>> 1.7.9.5
