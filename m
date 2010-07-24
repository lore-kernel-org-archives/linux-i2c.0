From: Trilok Soni <tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] i2c: QUP based bus driver for Qualcomm MSM chipsets
Date: Sat, 24 Jul 2010 20:38:49 +0530
Message-ID: <4C4B0201.9060106@codeaurora.org>
References: <1279853264-16311-1-git-send-email-kheitke@codeaurora.org> <4C494086.5080408@codeaurora.org> <4C49E5EE.2070103@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C49E5EE.2070103-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ken,

> 
>>
>>> +
>>> +    if (!pdata->msm_i2c_config_gpio) {
>>> +        dev_err(&pdev->dev, "config_gpio function not initialized\n");
>>> +        ret = -ENOSYS;
>>> +        goto err_config_failed;
>>> +    }
>>
>> I don't agree here. What if I do all the gpio configuration from the bootloader itself,
>> because I know that the device I am working on is production device and don't change
>> its configuration, then why I should provide the pdata hooks from the board files?
> 
> The reason that this hook is required is so that the driver can enable and disable the GPIOs as needed (although we currently only enable them).
> 
>>
>> Please also specify what are the operations we are doing in the msm_i2c_config_gpio?
> 
> Takes ownership of the GPIOs that are needed and assigns the ownership to the i2c controller.  The drive strength is also set.

Right, so due to these reasons I prefer not to have __must__ have check for pdata->msm_i2c_config_gpio hook's unavailability. It
might happen that some of the systems do all these ownership and pad muxing into the bootloader itself.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
