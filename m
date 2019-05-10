From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 3/3] i2c: i801: avoid panic if ioreamp fails
Date: Fri, 10 May 2019 10:09:55 +0200
Message-ID: <20190510100955.497a1a57@endymion>
References: <20190510030320.109154-1-wangkefeng.wang@huawei.com>
        <20190510030320.109154-3-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510030320.109154-3-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
List-Id: linux-i2c@vger.kernel.org

Hi Kefeng,

On Fri, 10 May 2019 11:03:20 +0800, Kefeng Wang wrote:
> If ioremap fails, NULL pointer dereference will happen and
> leading to a kernel panic when access the virtual address
> in check_signature().
> 
> Fix it by check the return value of ioremap.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 679c6c41f64b..fc6ccb8aba17 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1068,7 +1068,10 @@ static void __init input_apanel_init(void)
>  	void __iomem *bios;
>  	const void __iomem *p;
>  
> -	bios = ioremap(0xF0000, 0x10000); /* Can't fail */
> +	bios = ioremap(0xF0000, 0x10000);
> +	if (!base)

That would be "if (!bios)". Please don't send patches without at least
test-building the result.

We don't need this anyway. The comment says it can't fail, so why
bother checking for a condition which will never happen?

> +		return -ENOMEM;
> +
>  	p = bios_signature(bios);
>  	if (p) {
>  		/* just use the first address */


-- 
Jean Delvare
SUSE L3 Support
