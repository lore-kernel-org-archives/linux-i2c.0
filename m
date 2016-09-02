From: Yadi <yadi.hu@windriver.com>
Subject: Re: [PATCH] i2c-eg20t: fix race between i2c init and interrupt enable
Date: Fri, 2 Sep 2016 18:05:40 +0800
Message-ID: <57C94EF4.8050704@windriver.com>
References: <1472439415-4024-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:47774 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbcIBKGh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Sep 2016 06:06:37 -0400
In-Reply-To: <1472439415-4024-1-git-send-email-yadi.hu@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.de, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org

Hi,guys

it may more make sense to add a check point on interrupt handler in case 
field 'pch_base_address' has been assigned a effective value when an 
interrupt arrives.

So something like:

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 137125b..4ac8a49 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -152,6 +152,7 @@ struct i2c_algo_pch_data {
         int pch_buff_mode_en;
         u32 pch_event_flag;
         bool pch_i2c_xfer_in_progress;
+       bool initflag;
  };

  /**
@@ -635,6 +636,8 @@ static irqreturn_t pch_i2c_handler(int irq, void *pData)
         u32 mode;

         for (i = 0, flag = 0; i < adap_info->ch_num; i++) {
+               if (!adap_info->pch_data[i].initflag)
+                       continue;
                 p = adap_info->pch_data[i].pch_base_address;
                 mode = ioread32(p + PCH_I2CMOD);
                 mode &= BUFFER_MODE | EEPROM_SR_MODE;
@@ -783,6 +786,7 @@ static int pch_i2c_probe(struct pci_dev *pdev,
         for (i = 0; i < adap_info->ch_num; i++) {
                 pch_adap = &adap_info->pch_data[i].pch_adapter;
                 adap_info->pch_i2c_suspended = false;
+               adap_info->pch_data[i].initflag = false;

                 adap_info->pch_data[i].p_adapter_info = adap_info;

@@ -806,6 +810,7 @@ static int pch_i2c_probe(struct pci_dev *pdev,
                         pch_pci_err(pdev, "i2c_add_adapter[ch:%d] 
FAILED\n", i);
                         goto err_add_adapter;
                 }
+               adap_info->pch_data[i].initflag = ture;
         }



Compared with last one,  which one is better?

Yadi



On 2016年08月29日 10:56, Yadi Hu wrote:
> From: "Yadi.hu" <yadi.hu@windriver.com>
>
> the driver executes request_irq() function before the base address
> of i2c registers is remapped in kernel space. If i2c controller
> shares an interrupt line with other devices,it is possible that
> an interrupt arrives immediately after request_irq() is called.
> Since the interrupt handler pch_i2c_handler() is active, it will
> read its own register to determine if this interrupt was from
> its own device.
> At this moment, base address of i2c registers is not remapped
> in kernel space yet,so the INT handler access a unknown address
> and a error occurs.
>
>   Bad IO access at port 0x18 (return inl(port))
>   Call Trace:
>    [<c102c733>] warn_slowpath_common+0x73/0xa0
>    [<c13109f5>] ? bad_io_access+0x45/0x50
>    [<c13109f5>] ? bad_io_access+0x45/0x50
>    [<c102c804>] warn_slowpath_fmt+0x34/0x40
>    [<c13109f5>] bad_io_access+0x45/0x50
>    [<c1310b62>] ioread32+0x22/0x40
>    [<c14c60db>] pch_i2c_handler+0x3b/0x120
>    [<c1092f34>] handle_irq_event_percpu+0x64/0x330
>    [<c109323b>] handle_irq_event+0x3b/0x60
>    [<c1095b50>] ? unmask_irq+0x30/0x30
>    [<c1095ba0>] handle_fasteoi_irq+0x50/0xe0
>    <IRQ>  [<c16e7e78>] ? do_IRQ+0x48/0xc0
>    [<c16e7f6f>] ? smp_apic_timer_interrupt+0x7f/0x17a
>    [<c16e7da9>] ? common_interrupt+0x29/0x30
>    [<c1008ebb>] ? mwait_idle+0x8b/0x2c0
>    [<c1009e8e>] ? cpu_idle+0x9e/0xc0
>    [<c16be408>] ? rest_init+0x6c/0x74
>    [<c19f770a>] ? start_kernel+0x311/0x318
>    [<c19f7231>] ? repair_env_string+0x51/0x51
>    [<c19f7078>] ? i386_start_kernel+0x78/0x7d
>   ---[ end trace eb3a1028f468a140 ]---
>   i2c_eg20t 0000:05:0c.2: pch_i2c_handler :I2C-3 mode(0) is not supported
>
> Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
> ---
>   drivers/i2c/busses/i2c-eg20t.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
> index 137125b..48483a5 100644
> --- a/drivers/i2c/busses/i2c-eg20t.c
> +++ b/drivers/i2c/busses/i2c-eg20t.c
> @@ -773,13 +773,6 @@ static int pch_i2c_probe(struct pci_dev *pdev,
>   	/* Set the number of I2C channel instance */
>   	adap_info->ch_num = id->driver_data;
>   
> -	ret = request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
> -		  KBUILD_MODNAME, adap_info);
> -	if (ret) {
> -		pch_pci_err(pdev, "request_irq FAILED\n");
> -		goto err_request_irq;
> -	}
> -
>   	for (i = 0; i < adap_info->ch_num; i++) {
>   		pch_adap = &adap_info->pch_data[i].pch_adapter;
>   		adap_info->pch_i2c_suspended = false;
> @@ -808,16 +801,23 @@ static int pch_i2c_probe(struct pci_dev *pdev,
>   		}
>   	}
>   
> +	ret = request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
> +		  KBUILD_MODNAME, adap_info);
> +	if (ret) {
> +		pch_pci_err(pdev, "request_irq FAILED\n");
> +		goto err_request_irq;
> +	}
> +
>   	pci_set_drvdata(pdev, adap_info);
>   	pch_pci_dbg(pdev, "returns %d.\n", ret);
>   	return 0;
>   
> +err_request_irq:
> +	pci_iounmap(pdev, base_addr);
>   err_add_adapter:
>   	for (j = 0; j < i; j++)
>   		i2c_del_adapter(&adap_info->pch_data[j].pch_adapter);
>   	free_irq(pdev->irq, adap_info);
> -err_request_irq:
> -	pci_iounmap(pdev, base_addr);
>   err_pci_iomap:
>   	pci_release_regions(pdev);
>   err_pci_req:
