From: Peter Rosin <peda@axentia.se>
Subject: Re: [patch 2/2] i2c: mux: mellanox: add driver
Date: Thu, 25 Aug 2016 10:53:15 +0200
Message-ID: <55016b6b-c593-44f2-49f5-78d6df60fd39@axentia.se>
References: <1472046988-111956-1-git-send-email-vadimp@mellanox.com>
 <9cf2abd0-443b-2964-c809-1ac5a4321f8b@axentia.se>
 <AM5PR0501MB2097482A438B1E22ED663174A2EA0@AM5PR0501MB2097.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM5PR0501MB2097482A438B1E22ED663174A2EA0@AM5PR0501MB2097.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

On 2016-08-24 18:20, Vadim Pasternak wrote:
> Hi Peter,
> 
> Thank you very much for your review.
> 
>> -----Original Message-----
>> From: Peter Rosin [mailto:peda@axentia.se]
>> Sent: Wednesday, August 24, 2016 4:55 PM
>> To: Vadim Pasternak <vadimp@mellanox.com>; wsa@the-dreams.de
>> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnulli.us;
>> Michael Shych <michaelsh@mellanox.com>
>> Subject: Re: [patch 2/2] i2c: mux: mellanox: add driver
>>
>> On 2016-08-24 15:56, Vadim Pasternak wrote:
>>> From: Vadim Pasternak <vadimp@mellanox.com>
>>>
>>> This driver allows I2C routing controlled through CPLD select
>>> registers on wide range of Mellanox systems (CPLD Lattice device).
>>> MUX selection is provided by digital and analog HW. Analog part is not
>>> under SW control. Digital part is under CPLD control (channel selection/de-
>> selection).
>>>
>>> MUX logic description.
>>> Mux selector can control 256 mux (channels), if utilized one CPLD
>>> register
>>> (8 bits) as select register - register value specifies mux id.
>>> Mux selector can control n*256 mux, if utilized n CPLD registers as
>>> select registers.
>>> The number of registers within the same CPLD can be combined to
>>> support mux hierarchy.
>>> This logic can be applied for LPC attached CPLD and fro I2C attached CPLD.
>>> Driver can support different mux control logic, according to CPLD
>>> implementation.
>>
>> This paragraph is strangely wrapped. And please limit to 75 chars per line as per
>> checkpatch.
>>
>> Also, I have a hard time getting the grips on the actual number of mux channels
>> that can be controlled. You talk about n * 256 channels if you have n registers.
>> But the code below appears to only deal with one register. So why complicate
>> things in the comments and the commit message? It is also not entirely clear to
>> me if you support 8 channels or if you really support 256 channels. That would
>> be huge number of pins.
> 
> In CPLD we have three channel selection registers, which one can support up to 256 channels.
> CPLD could be programmed with the bigger number of selection registers.
> I tried to explain it in description.
> Since it's misleading, I'll remove it.

I'm a curious bastard though, and now I want to know how it works :-)
So, the CPLD supports up to 768 channels, using three registers, but there
is no HW that makes use of all of the options of this building block?
At least there's no such "big" system yet?

But then I wonder if that wouldn't be three parallel muxes, i.e. one mux
for each register? Otherwise you would only need two more bits to get
three times the number of channels...

>>
>> Because from the text above, I would have guessed 256, but below...
>>
>>> Connectivity schema.
>>> i2c-mlxcpld                                 Digital               Analog
>>> driver
>>> *--------*                                 * -> mux1 (virt bus2) -> mux -> |
>>> | I2CLPC | i2c physical                    * -> mux2 (virt bus3) -> mux -> |
>>> | bridge | bus 1                 *---------*                               |
>>> | logic  |---------------------> * mux reg *                               |
>>> | in CPLD|                       *---------*                               |
>>> *--------*   i2c-mux-mlxpcld          ^    * -> muxn (virt busn) -> mux -> |
>>>     |        driver                   |                                    |
>>>     |        *---------------*        |                              Devices
>>>     |        * CPLD (LPC bus)* select |
>>>     |        * registers for *--------*
>>>     |        * mux selection * deselect
>>>     |        *---------------*
>>>     |                 |
>>> <-------->     <----------->
>>> i2c cntrl      Board cntrl reg
>>> reg space      space (mux select,
>>>     |          IO, LED, WD, info)
>>>     |                 |                  *-----*   *-----*
>>>     *------------- LPC bus --------------| PCH |---| CPU |
>>>                                          *-----*   *-----*
>>>
>>> i2c-mux-mlxpcld does not necessary required i2c-mlxcpld. It can be use
>>> along with another bus driver, and still control i2c routing through
>>> CPLD mux selection, in case the system is equipped with CPLD capable
>>> of mux selection control.
>>>
>>> The Kconfig currently controlling compilation of this code is:
>>> drivers/i2c/muxes/Kconfig:config I2C_MUX_MLXCPLD
>>>
>>> Signed-off-by: Michael Shych <michaelsh@mellanox.com>
>>> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
>>> Reviewed-by: Jiri Pirko <jiri@mellanox.com>
>>> ---
>>>  drivers/i2c/muxes/Kconfig           |  11 ++
>>>  drivers/i2c/muxes/Makefile          |   1 +
>>>  drivers/i2c/muxes/i2c-mux-mlxcpld.c | 352
>> ++++++++++++++++++++++++++++++++++++
>>>  include/linux/i2c/mlxcpld.h         |  67 +++++++
>>>  4 files changed, 431 insertions(+)
>>>  create mode 100644 drivers/i2c/muxes/i2c-mux-mlxcpld.c
>>>  create mode 100644 include/linux/i2c/mlxcpld.h
>>>
>>> a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
>>> b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
>>> new file mode 100644
>>> index 0000000..ae860de
>>> --- /dev/null
>>> +++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
>>> @@ -0,0 +1,352 @@

*snip*

>>> +#include <linux/device.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/i2c-mux.h>
>>> +#include <linux/io.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/i2c/mlxcpld.h>
>>> +
>>> +#define CPLD_MUX_MAX_NCHANS	8
>>> +#define CPLD_MUX_EXT_MAX_NCHANS	24
>>
>> ...here, you say 8. Or 24 for some ext thingy, which is not mentioned in the
>> commit message. So, what's going on? Why mess things up by mentioning 256?
>>
> Yes, we have systems only with 8 and 24 channels.
> Since through one register it's possible to control up to 256 channels, I mentioned it in description.
> I'll remove it. 
>>> +
>>> +/*
>>> + * mlxcpld_mux types - kind of mux supported by driver:
>>> + * @mlxcpld_mux_tor - LPC access; 8 channels/legs; select/deselect -
>>> + *		      channel=first defined channel(2/10) + channel/leg
>>> + * @mlxcpld_mux_mgmt - LPC access; 8 channels/legs; select/deselect  -
>>> + *		       channel=1 + channel/leg
>>> + * @mlxcpld_mux_mgmt_ext - LPC access; 24 channels/legs; select/deselect
>> -
>>> + *			   channel=1 + channel/leg
>>> + * @mlxcpld_mux_module - I2C access; 8 channels/legs; select/deselect  -
>>> + *			 channel=1 + channel/leg
>>> + */
>>
>> Channels? Legs? If they are the same, then pick one name, and use it
>> throughout. I prefer channels in that case.
> 
> Channels.
> 
>>
>> If you mean channels per leg, then you need to define what a leg is.
>>
>>> +enum mlxcpld_mux_type {
>>> +	mlxcpld_mux_tor,
>>> +	mlxcpld_mux_mgmt,
>>> +	mlxcpld_mux_mgmt_ext,
>>> +	mlxcpld_mux_module,
>>> +};

*snip*

>>> +
>>> +/* Write to mux register. Don't use i2c_transfer() and
>>> + * i2c_smbus_xfer() for this as they will try to lock adapter a
>>> +second time  */ static int mlxcpld_mux_reg_write(struct i2c_adapter
>>> +*adap,
>>> +				 struct i2c_client *client, u8 val,
>>> +				 enum mlxcpld_mux_access_type muxtype) {
>>> +	struct mlxcpld_mux_platform_data *pdata =
>>> +						dev_get_platdata(&client-
>>> dev);
>>> +	int ret = -ENODEV;
>>> +
>>> +	switch (muxtype) {
>>> +	case lpc_access:
>>> +		outb(val, pdata->addr); /* addr = CPLD base + offset */
>>> +		ret = 1;
>>> +		break;
>>> +
>>> +	case i2c_access:
>>> +		if (adap->algo->master_xfer) {
>>> +			struct i2c_msg msg;
>>> +			u8 msgbuf[] = {pdata->sel_reg_addr, val};
>>
>> You assume there is pdata for all muxes connected via i2c. Is that certain?
> 
> Yes
> 
>>
>>> +
>>> +			msg.addr = pdata->addr;
>>> +			msg.flags = 0;
>>> +			msg.len = 2;
>>> +			msg.buf = msgbuf;
>>> +			return adap->algo->master_xfer(adap, &msg, 1);

Forgot last time, __i2c_transfer is better for unlocked transfers.

>>> +		}
>>> +		dev_err(&client->dev, "SMBus isn't supported on this
>> adapter\n");
>>> +		break;
>>> +
>>> +	default:
>>> +		dev_err(&client->dev, "Incorrect muxtype %d\n", muxtype);
>>> +	}
>>> +
>>> +	return ret;
>>> +}

*snip*

>>> +/* I2C init/probing/exit functions */ static int
>>> +mlxcpld_mux_probe(struct i2c_client *client,
>>> +			     const struct i2c_device_id *id) {
>>> +	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
>>> +	struct mlxcpld_mux_platform_data *pdata =
>>> +						dev_get_platdata(&client-
>>> dev);
>>> +	struct i2c_mux_core *muxc;
>>> +	int num, force;
>>> +	u8 nchans;
>>> +	struct mlxcpld_mux *data;
>>> +	int err;
>>> +
>>> +	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
>>> +		return -ENODEV;
>>> +
>>> +	switch (id->driver_data) {
>>> +	case mlxcpld_mux_tor:
>>> +	case mlxcpld_mux_mgmt:
>>> +	case mlxcpld_mux_mgmt_ext:
>>> +	case mlxcpld_mux_module:
>>> +		nchans = muxes[id->driver_data].nchans;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	muxc = i2c_mux_alloc(adap, &client->dev, nchans, sizeof(*data), 0,
>>> +			     mlxcpld_mux_select_chan, mlxcpld_mux_deselect);
>>> +	if (!muxc)
>>> +		return -ENOMEM;
>>> +
>>> +	data = i2c_mux_priv(muxc);
>>> +	i2c_set_clientdata(client, muxc);
>>> +	data->client = client;
>>> +	data->type = id->driver_data;
>>> +	data->last_chan = 0; /* force the first selection */
>>> +
>>> +	/* Only in mlxcpld_mux_tor first_channel can be different.
>>> +	 * In other mlxcpld_mux types channel numbering begin from 1
>>> +	 * Now create an adapter for each channel
>>> +	 */
>>> +	for (num = 0; num < muxes[data->type].nchans; num++) {
>>> +		force = 0; /* dynamic adap number */
>>> +		if (pdata) {
>>> +			if (num < pdata->num_modes)
>>> +				force = pdata->first_channel + num;
>>
>> It looks as if you, as soon as pdata is supplied, tie the adapter number to the
>> needed register value to select the mux channel.
>> That's not good. At all.
>>
>> Looks like you need to dig into pdata->modes[num].adap_id
> 
> Do you suggest to replace 
> force = pdata->first_channel + num; with
> force = pdata->modes[num].adap_id;
> Right?

Right, then you have the option to number the adapters however you
like. Of course, you could still fill in adap_id so that they match
first_channel + num, but you also have the option of setting adap_id
to zero and have the system allocate the adapter number at runtime.

*snip*

>>> diff --git a/include/linux/i2c/mlxcpld.h b/include/linux/i2c/mlxcpld.h
>>> new file mode 100644 index 0000000..cc3236e
>>> --- /dev/null
>>> +++ b/include/linux/i2c/mlxcpld.h
>>> @@ -0,0 +1,67 @@

*snip*

>>> +#ifndef _LINUX_I2C_MLXCPLD_H
>>> +#define _LINUX_I2C_MLXCPLD_H
>>> +
>>> +/* Platform data for the CPLD I2C multiplexers */
>>> +
>>> +/* mlxcpld_mux_platform_mode - per channel initialisation data:
>>> + * @adap_id: bus number for the adapter. 0 = don't care
>>> + * @deselect_on_exit: set this entry to 1, if your H/W needs deselection
>>> + *		      of this channel after transaction.
>>> + */
>>> +struct mlxcpld_mux_platform_mode {
>>> +	int adap_id;
>>> +	unsigned int deselect_on_exit;
>>> +};
>>
>> deselect_on_exit is not used anywhere...
>>
>>> +
>>> +/* mlxcpld_mux_platform_data - per mux data, used with
>>> +i2c_register_board_info
>>> + * @modes - mux configuration model
>>> + * @num_modes - number of adapters
>>> + * @sel_reg_addr - mux select register offset in CPLD space
>>> + * @first_channel - first channel to start virtual busses vector
>>> + * @addr - address of mux device - set to mux select register offset on LPC
>>> + *	   connected CPLDs or to I2C address on I2C conncted CPLDs
>>> + */
>>> +struct mlxcpld_mux_platform_data {
>>> +	struct mlxcpld_mux_platform_mode *modes;
>>
>> ...in fact, this entire member is not used at all, which makes the above struct
>> mlxcpld_mux_platform_mode useless. Unless you intend to fix the above
>> problem with mixing channel number with adapter number.
> 
> I'll remove mlxcpld_mux_platform_data and replace *modes with *adap_id.
> When select registers is written out, the previous value is overwritten.

If writing a value with no corresponding channel to the select register
causes all real channels to be deselected, that could be used to support
deselect_on_exit. If you like?

>>
>>> +	int num_modes;
>>> +	int sel_reg_addr;
>>> +	int first_channel;
>>> +	unsigned short addr;
>>> +};
>>> +
>>> +#endif /* _LINUX_I2C_MLXCPLD_H */
>>>
>>
>> I'm missing an entry in MAINTAINERS. Who will fix problems?
> 
> I'll add at myself.
> 
>> I'm missing devicetree bindings. Is that not applicable?
> 
> It could be something very simple, like
> cpldmux@da {
>                 compatible = "i2c-mux-mlxcpld";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                i2c@0 {
>                   ...
>                }
> }
> Do you think it worth adding?

compatible should have a vendor prefix (present in
Documentation/devicetree/bindings/vendor-prefixes.txt), and you'd
need a way to distinguish the four different variants, e.g.
"mellanox,i2c-mux-cpld-tor"

You'd also need some properties to fill in the info that you would
otherwise get from pdata.

But if the device can't exist on any system that uses devicetree,
then I don't think devicetree support makes much sense. And it can
always be added later...

> Also most of our systems is based x86 (but also PPC).
> So I'll must to add
> #ifdef CONFIG_OF
> static const struct of_device_id i2c_mux_mlxcpld_of_match[] = {
>         { .compatible = " i2c-mux-mlxcpld ", },
>         {},
> };
> MODULE_DEVICE_TABLE(of, i2c_mux_mlxcpld_of_match);
> #endif
> 
> Do you th9ink it's OK to have such ifdef?

Such an ifdef is ok, but you'd need four entries here as well,

BTW, if you don't have need for devicetree, how are you instantiating
the driver? And where is the code that fills in pdata, because it
feels like pdata is unconditional?

Cheers,
Peter
