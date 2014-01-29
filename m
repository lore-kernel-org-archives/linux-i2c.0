From: "xinhui.pan" <xinhuix.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-designware-pcidrv: fix the incorrect return of idle
 callback
Date: Wed, 29 Jan 2014 18:00:26 +0800
Message-ID: <52E8D13A.1060100@intel.com>
References: <52E744AC.2050606@intel.com> <20140128183035.GC20789@katana> <20140129083548.GG18029@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140129083548.GG18029-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bo.he-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



=E4=BA=8E 2014=E5=B9=B401=E6=9C=8829=E6=97=A5 16:35, Mika Westerberg =E5=
=86=99=E9=81=93:
> On Tue, Jan 28, 2014 at 07:30:35PM +0100, Wolfram Sang wrote:
>> On Tue, Jan 28, 2014 at 01:48:28PM +0800, xinhui.pan wrote:
>>> From: "xinhui.pan" <xinhuix.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>>
>>> i2c_dw_pci_runtime_idle should return -EBUSY rather than zero if it=
 do success.
>>
>> I don't understand...
>>
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
>=20
> If I understand correctly, pm_schedule_suspend(dev, 500) is there bec=
ause
> we want to runtime suspend in 500 ms. It then returns -EBUSY to preve=
nt PM
> runtime from carrying on suspend on it's own. However, I have no idea=
 where
> this magical 500 ms requirement comes from.
>=20
> If we fail to schedule suspend we let the PM core to do whatever it t=
hinks
> suitable (in this case I suppose it suspends the device).
>=20

Hi ,Mika
  If the callback returns 0,it means pm_schedule_suspend fails,
also means rpm_check_suspend_allowed(pm_schedule_suspend calls it)=20
returns nonzero value.As a result,rpm_suspend will be called by rpm_idl=
e.
  However in rpm_idle, rpm_check_suspend_allowed is called at first,too=
=2E
and the return value is treated as it is.But rpm_idle just returns=20
without doing anything(rpm_suspend is not called).=20
  in both case above,why goes in different ways? I am confused.
=20
> I think the whole idle dance could be replaced with a use of runtime =
PM
> autosuspend, just like we do in the platform version of the driver.
>=20
> Xinghui,
>=20
> Is this a real problem that you are trying to solve?
>=20

To be honest,we got many panic when testing.
But is not caused by this driver I think.
while checking problems,we found these confusing codes by accident.
