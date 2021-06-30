Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16424C11F65
	for <linux-i2c@archiver.kernel.org>; Wed, 30 Jun 2021 06:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA66561C9C
	for <linux-i2c@archiver.kernel.org>; Wed, 30 Jun 2021 06:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhF3Gsv (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 30 Jun 2021 02:48:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:51313 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232445AbhF3Gsu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 30 Jun 2021 02:48:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="188677265"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="188677265"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 23:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="641596945"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58]) ([10.239.154.58])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2021 23:45:56 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com, viresh.kumar@linaro.org,
        stefanha@redhat.com, pbonzini@redhat.com
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
From:   Jie Deng <jie.deng@intel.com>
Message-ID: <05cc9484-f97b-0533-64fe-ff917c6b87ee@intel.com>
Date:   Wed, 30 Jun 2021 14:45:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YNrw4rxihFLuqLtY@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 2021/6/29 18:07, Wolfram Sang wrote:

> Hi,
>
> so some minor comments left:
>
>> +		if (!msgs[i].len)
>> +			break;
> I hope this can extended in the future to allow zero-length messages. If
> this is impossible we need to set an adapter quirk instead.


Yes, we can support it by removing this check and call it zero-length 
request.
It don't think it will break anything.


>
>> +		err = virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL);
>> +		if (err < 0) {
>> +			pr_err("failed to add msg[%d] to virtqueue.\n", i);
> Is it really helpful for the user to know that msg5 failed? We don't
> even say which transfer.


OK. I will remove this print.


>> +static u32 virtio_i2c_func(struct i2c_adapter *adap)
>> +{
>> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> You are not emulating I2C_FUNC_SMBUS_QUICK, so you need to mask it out.


I will remove the check of  zero-length message.


>
>> +	snprintf(vi->adap.name, sizeof(vi->adap.name), "Virtio I2C Adapter");
> Is there something to add so you can distinguish multiple instances?
> Most people want that.


I find the I2C core will set a device name "i2c-%d" for this purpose, right?

I think this name can be used to distinguish the adapter types while 
"i2c-%d" can be used to

distinguish instances. Does it make sense ?


>> +	vi->adap.class = I2C_CLASS_DEPRECATED;
>> +	vi->adap.algo = &virtio_algorithm;
>> +	vi->adap.dev.parent = &vdev->dev;
>> +	vi->adap.timeout = HZ / 10;
> Why so short? HZ is the kinda default value.


Ah... I didn't know the I2C core had already set a default value.
I will remove this line to use the default one.


>
>> +	i2c_set_adapdata(&vi->adap, vi);
>> +
>> +	/* Setup ACPI node for controlled devices which will be probed through ACPI */
>> +	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(pdev));
>> +
>> +	ret = i2c_add_adapter(&vi->adap);
>> +	if (ret) {
>> +		virtio_i2c_del_vqs(vdev);
>> +		dev_err(&vdev->dev, "failed to add virtio-i2c adapter.\n");
> Won't the driver core print that for us?


Yes. It seems unnecessary. Will remove it.


>
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/* The bit 0 of the @virtio_i2c_out_hdr.@flags, used to group the requests */
>> +#define VIRTIO_I2C_FLAGS_FAIL_NEXT	0x00000001
> BIT(0)?


That's better. Thank you.


>
> Happy hacking,
>
>     Wolfram
>
