From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] of/i2c: Generalize OF support
Date: Thu, 10 Jun 2010 10:58:15 -0600
Message-ID: <AANLkTikNDUUc7WODmtOYRf-vDzgWpWTI6kpneUEOPogz@mail.gmail.com>
References: <20100610052102.16222.86662.stgit@angua> <20100610052232.16222.942.stgit@angua>
	<20100610095226.GI5333@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100610095226.GI5333-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 10, 2010 at 3:52 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> Hi Grant,
>
> looks good to me in general. A few questions:
>
> On Wed, Jun 09, 2010 at 11:22:32PM -0600, Grant Likely wrote:
>> This patch cleans up the i2c OF support code to make it selectable b=
y
>> all architectures and allow for automatic registration of i2c device=
s.
>>
>> Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> ---
>> =A0drivers/i2c/busses/i2c-cpm.c =A0 =A0 | =A0 =A03 ++-
>> =A0drivers/i2c/busses/i2c-ibm_iic.c | =A0 =A03 ++-
>> =A0drivers/i2c/busses/i2c-mpc.c =A0 =A0 | =A0 =A03 ++-
>> =A0drivers/of/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
>> =A0drivers/of/of_i2c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 44 +++++++++=
+++++++++++++++--------------
>> =A0include/linux/of_i2c.h =A0 =A0 =A0 =A0 =A0 | =A0 13 +++++++++--
>> =A06 files changed, 45 insertions(+), 23 deletions(-)
>>

Hi Wolfram, thanks for the review.  Replies below.

>> @@ -49,10 +64,8 @@ void of_register_i2c_devices(struct i2c_adapter *=
adap,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D i2c_new_device(adap, &info);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result =3D=3D NULL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"of-i2c: Fa=
iled to load driver for %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info.type);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_dispose_mapping(info.i=
rq);
>
> Why is the dispose removed?

Hmmm... That looks like a mistake.  I'll add it back.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "of_i2=
c: Failure registering %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node->full=
_name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> @@ -64,7 +77,7 @@ void of_register_i2c_devices(struct i2c_adapter *a=
dap,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_get(node);
>> =A0 =A0 =A0 }
>> =A0}
>> -EXPORT_SYMBOL(of_register_i2c_devices);
>> +EXPORT_SYMBOL(of_i2c_register_devices);
>>
>> =A0static int of_dev_node_match(struct device *dev, void *data)
>> =A0{
>> @@ -76,8 +89,7 @@ struct i2c_client *of_find_i2c_device_by_node(stru=
ct device_node *node)
>> =A0{
>> =A0 =A0 =A0 struct device *dev;
>>
>> - =A0 =A0 dev =3D bus_find_device(&i2c_bus_type, NULL, node,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0of_dev_node_match);
>> + =A0 =A0 dev =3D bus_find_device(&i2c_bus_type, NULL, node, of_dev_=
node_match);
>
> This change looks unrelated to me; where was this changed?

You're right; unrelated whitespace damage.  I'll remove.

g.
