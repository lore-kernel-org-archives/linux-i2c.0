From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 3/3] i2c: i801: avoid panic if ioreamp fails
Date: Sat, 11 May 2019 09:32:12 +0800
Message-ID: <b76a3c35-015f-8ecb-0dd1-1329ee93e637@huawei.com>
References: <20190510030320.109154-1-wangkefeng.wang@huawei.com>
 <20190510030320.109154-3-wangkefeng.wang@huawei.com>
 <20190510100955.497a1a57@endymion>
 <164bb498-35dc-b226-4adb-3d743f4790a1@huawei.com>
 <20190510141833.2cb3d108@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510141833.2cb3d108@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
List-Id: linux-i2c@vger.kernel.org


On 2019/5/10 20:18, Jean Delvare wrote:
> On Fri, 10 May 2019 17:35:46 +0800, Kefeng Wang wrote:
>> On 2019/5/10 16:09, Jean Delvare wrote:
>>> We don't need this anyway. The comment says it can't fail, so why
>>> bother checking for a condition which will never happen?  
>> The ioremap could fails due to no memory, our inner test robot(enable FAULT_INJECTION)
>>
>> find this issue.
> The code only runs on x86 where this specific memory segment is
> standardized for the purpose. That's how we know it "can't fail".
>
> That being said, maybe it could fail for other reasons (internal kernel
> bug, or bogus BIOS maybe), and I don't care adding the check
> anyway, as this code path is not performance critical.
Got it , please ignore it.
>
