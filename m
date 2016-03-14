From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] i2c: i2c-core: do not use bus internal data
Date: Mon, 14 Mar 2016 12:15:01 +0000
Message-ID: <CAPKp9ubNH+e+7J7M0ZbuSoJw+xYj5J3i_xc0fm6_Ktns68Tg6g@mail.gmail.com>
References: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
	<20160314091819.GA27975@ulmo>
	<20160314092754.GB27975@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33300 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbcCNMPC (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 08:15:02 -0400
In-Reply-To: <20160314092754.GB27975@ulmo>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: open list <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Mon, Mar 14, 2016 at 9:27 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, Mar 14, 2016 at 10:18:19AM +0100, Thierry Reding wrote:
>> On Mon, Mar 07, 2016 at 05:19:17PM +0530, Sudip Mukherjee wrote:
>> > The variable p is a data structure which is used by the driver core
>> > internally and it is not expected that busses will be directly accessing
>> > these driver core internal only data.
>> >
>> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>> > ---
>> >
>> > Reference of Greg's comment about it at:
>> > https://lkml.org/lkml/2016/3/5/171
>> >
>> >  drivers/i2c/i2c-core.c | 6 ++++--
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> > index 2949ab3..2f31fb5 100644
>> > --- a/drivers/i2c/i2c-core.c
>> > +++ b/drivers/i2c/i2c-core.c
>> > @@ -73,6 +73,7 @@ static struct device_type i2c_client_type;
>> >  static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
>> >
>> >  static struct static_key i2c_trace_msg = STATIC_KEY_INIT_FALSE;
>> > +static bool is_registered;
>> >
>> >  void i2c_transfer_trace_reg(void)
>> >  {
>> > @@ -1529,7 +1530,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>> >     int res = 0;
>> >
>> >     /* Can't register until after driver model init */
>> > -   if (unlikely(WARN_ON(!i2c_bus_type.p))) {
>> > +   if (unlikely(WARN_ON(!is_registered))) {
>> >             res = -EAGAIN;
>> >             goto out_list;
>> >     }
>> > @@ -1926,7 +1927,7 @@ int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
>> >     int res;
>> >
>> >     /* Can't register until after driver model init */
>> > -   if (unlikely(WARN_ON(!i2c_bus_type.p)))
>> > +   if (unlikely(WARN_ON(!is_registered)))
>> >             return -EAGAIN;
>> >
>> >     /* add the driver to the list of i2c drivers in the driver core */
>> > @@ -2118,6 +2119,7 @@ static int __init i2c_init(void)
>> >     if (IS_ENABLED(CONFIG_OF_DYNAMIC))
>> >             WARN_ON(of_reconfig_notifier_register(&i2c_of_notifier));
>> >
>> > +   is_registered = true;
>> >     return 0;
>> >
>> >  class_err:
>>
>> This doesn't work. I see a number of these WARN_ON()s trigger and I
>> think the reason is that i2c_init() always fails now. The cause seems to
>> be that i2c_init() calls i2c_add_driver(&dummy_driver), which will now
>> always fail, because is_register is set to true *after* that call. There
>> is no way I see I2C working at all after this patch.

Exactly, and this is resulting in recursive failures on dev platform ending up
in boot failure

>
> FWIW, the below on top of your patch seems to fix things for me.
>

I too came up with same patch, good that I searched before posting it out.
FWIW, it fixes the recursive fault at boot on my arm64 platform.

Regards,
Sudeep
