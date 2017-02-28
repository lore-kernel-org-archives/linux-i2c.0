From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [LKP] [usb] bea5b158ff WARNING: CPU: 0 PID: 25 at
 drivers/usb/core/urb.c:338 usb_submit_urb
Date: Tue, 28 Feb 2017 12:52:48 +0800
Message-ID: <20170228045248.5inqpcgwq3qumtyk@wfg-t540p.sh.intel.com>
References: <20170226101959.hhtbjj4ee6ujxdr4@wfg-t540p.sh.intel.com>
 <20170227095442.GA26576@b29397-desktop>
 <20170228014739.GB12307@yexl-desktop>
 <20170228043255.GD9855@yexl-desktop>
 <20170228044709.GA19456@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170228044709.GA19456@b29397-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Ye Xiaolong <xiaolong.ye@intel.com>, Rob Herring <robh@kernel.org>, Felipe Balbi <felipe.balbi@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, LKP <lkp@01.org>
List-Id: linux-i2c@vger.kernel.org

>> The dummy_udc WARN is gone with this patch for 100+ times of boot tests.
>>
>> Tested-by: Xiaolong Ye <xiaolong.ye@intel.com>
>>
>> Thanks,
>> Xiaolong
>>
>
>Thanks, Xiaolong. I will submit a patch for it.

Thank you Peter! We've been noised by this warning for quite some time.

Fengguang
