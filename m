From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 3/3] i2c: i801: avoid panic if ioreamp fails
Date: Fri, 10 May 2019 14:18:33 +0200
Message-ID: <20190510141833.2cb3d108@endymion>
References: <20190510030320.109154-1-wangkefeng.wang@huawei.com>
        <20190510030320.109154-3-wangkefeng.wang@huawei.com>
        <20190510100955.497a1a57@endymion>
        <164bb498-35dc-b226-4adb-3d743f4790a1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <164bb498-35dc-b226-4adb-3d743f4790a1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, 10 May 2019 17:35:46 +0800, Kefeng Wang wrote:
> On 2019/5/10 16:09, Jean Delvare wrote:
> > We don't need this anyway. The comment says it can't fail, so why
> > bother checking for a condition which will never happen?  
> 
> The ioremap could fails due to no memory, our inner test robot(enable FAULT_INJECTION)
> 
> find this issue.

The code only runs on x86 where this specific memory segment is
standardized for the purpose. That's how we know it "can't fail".

That being said, maybe it could fail for other reasons (internal kernel
bug, or bogus BIOS maybe), and I don't care adding the check
anyway, as this code path is not performance critical.

-- 
Jean Delvare
SUSE L3 Support
