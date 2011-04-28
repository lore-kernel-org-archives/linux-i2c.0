From: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: append hardware lock with bus lock
Date: Thu, 28 Apr 2011 16:36:02 +0800
Message-ID: <BANLkTin6jguQue_0Y74jGPnmhCcvWLBjHg@mail.gmail.com>
References: <1303963358-4652-1-git-send-email-haojian.zhuang@gmail.com> <20110428102212.2d8d607c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110428102212.2d8d607c-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 28, 2011 at 4:22 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> Hi Haojian,
>
> On Thu, 28 Apr 2011 12:02:36 +0800, Haojian Zhuang wrote:
>> Both AP and CP are contained in Marvell PXA910 silicon. These two AR=
M
>> cores are sharing one pair of I2C pins.
>>
>> In order to keep I2C transaction operated with atomic, hardware lock
>> (RIPC) is required. Because of this, bus lock in AP side can't affor=
d
>> this requirement. Now hardware lock is appended.
>
> I have no objection to the idea, but one question: when using the
> hardware lock, isn't the software mutex redundant? I would expect tha=
t
> you call the hardware_lock/unlock functions _instead_ of
> rt_mutex_lock/unlock, rather than in addition to it. Or do you still
> need the rt_mutex to prevent priority inversion?
>

Jean,

It's actually not redundant. The hardware lock is used to protect
access to the same register regions between two processors (AP
and CP so called), while the software lock is used to protect
access from within the AP side.

>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> ---
>> =C2=A0drivers/i2c/i2c-core.c | =C2=A0 22 ++++++++++++++++++----
>> =C2=A0include/linux/i2c.h =C2=A0 =C2=A0| =C2=A0 =C2=A03 +++
>> =C2=A02 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 045ba6e..412c7a5 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -448,8 +448,11 @@ void i2c_lock_adapter(struct i2c_adapter *adapt=
er)
>>
>> =C2=A0 =C2=A0 =C2=A0 if (parent)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_lock_adapter(pa=
rent);
>> - =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rt_mutex_lock(&adap=
ter->bus_lock);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adapter->hardware_lo=
ck)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 adapter->hardware_lock();
>> + =C2=A0 =C2=A0 }
>> =C2=A0}
>> =C2=A0EXPORT_SYMBOL_GPL(i2c_lock_adapter);
>>
>> @@ -460,11 +463,19 @@ EXPORT_SYMBOL_GPL(i2c_lock_adapter);
>> =C2=A0static int i2c_trylock_adapter(struct i2c_adapter *adapter)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter *parent =3D i2c_parent_is_i2=
c_adapter(adapter);
>> + =C2=A0 =C2=A0 int ret =3D 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (parent)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return i2c_trylock_=
adapter(parent);
>> - =C2=A0 =C2=A0 else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rt_mutex_trylock(=
&adapter->bus_lock);
>> + =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D rt_mutex_trylock=
(&adapter->bus_lock);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret && adapter->hard=
ware_trylock) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ret =3D adapter->hardware_trylock();
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_unlock_adapter(adapter);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> + =C2=A0 =C2=A0 }
>> =C2=A0}
>>
>> =C2=A0/**
>> @@ -477,8 +488,11 @@ void i2c_unlock_adapter(struct i2c_adapter *ada=
pter)
>>
>> =C2=A0 =C2=A0 =C2=A0 if (parent)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_unlock_adapter(=
parent);
>> - =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adapter->hardware_un=
lock)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 adapter->hardware_unlock();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rt_mutex_unlock(&ad=
apter->bus_lock);
>> + =C2=A0 =C2=A0 }
>> =C2=A0}
>> =C2=A0EXPORT_SYMBOL_GPL(i2c_unlock_adapter);
>>
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index 06a8d9c..b283b4e 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -361,6 +361,9 @@ struct i2c_adapter {
>>
>> =C2=A0 =C2=A0 =C2=A0 /* data fields that are valid for all devices =C2=
=A0 */
>> =C2=A0 =C2=A0 =C2=A0 struct rt_mutex bus_lock;
>> + =C2=A0 =C2=A0 void (*hardware_lock)(void);
>> + =C2=A0 =C2=A0 void (*hardware_unlock)(void);
>> + =C2=A0 =C2=A0 int (*hardware_trylock)(void);
>>
>> =C2=A0 =C2=A0 =C2=A0 int timeout; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* in jiffies */
>> =C2=A0 =C2=A0 =C2=A0 int retries;
>
>
> --
> Jean Delvare
>
