From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [RESEND] i2c: imx: defer probing on dma channel request
Date: Tue, 26 Mar 2019 11:52:41 +0000
Message-ID: <7c702cc4-4bb6-02e8-6c2d-1686de503c85@nxp.com>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
 <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
Content-Language: en-US
Content-ID: <3C8F1440CFA3E043A3530EFD5C69E812@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Steven Price <steven.price@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Ying Zhang <ying.zhang22455@nxp.com>
Cc: "upstream-release@linux.nxdi.nxp.com" <upstream-release@linux.nxdi.nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hi Steve,

Thanks for the review! Few comments inline.

On 25.03.2019 19:12, Steven Price wrote:
> On 25/03/2019 15:30, laurentiu.tudor@nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> If the dma controller is not yet probed, defer i2c probe.
>> The error path in probe was slightly modified (no functional change)
> 
> There is a functional change for cases like:
> 
>> 	ret = pm_runtime_get_sync(&pdev->dev);
>> 	if (ret < 0)
>> 		goto rpm_disable;
> 
> ...as rpm_disable will no longer fall through to the call of
> clk_disable_unprepare().

Good point, I missed that.

>> to avoid triggering this WARN_ON():
>> "cg-pll0-div1 already disabled
>> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb0"
> 
> I'm also not sure how this WARN_ON was hit. i2c_imx_probe() calls
> clk_prepare_enable() which should increment the reference count. So it
> should always be possible to decrememt the enable_count. What am I missing?

I am no longer able to replicate this. Perhaps in the mean time changes 
in the clk core fixed this corner case.

>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>   drivers/i2c/busses/i2c-imx.c | 21 +++++++++++++--------
>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index 42fed40198a0..4e34b1572756 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -1111,7 +1111,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
>>   				pdev->name, i2c_imx);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
>> -		goto clk_disable;
>> +		clk_disable_unprepare(i2c_imx->clk);
>> +		return ret;
>>   	}
>>   
>>   	/* Init queue */
>> @@ -1161,19 +1162,25 @@ static int i2c_imx_probe(struct platform_device *pdev)
>>   	pm_runtime_mark_last_busy(&pdev->dev);
>>   	pm_runtime_put_autosuspend(&pdev->dev);
>>   
>> +	/* Init DMA config if supported */
>> +	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
>> +	if (ret) {
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_info(&pdev->dev, "can't use DMA, using PIO instead.\n");
>> +		else
>> +			goto del_adapter;
>> +	}
>> +
> 
> This can be simplified by reversing the condition:

Well, in the mean time I just found out that this commit [1] fixes the 
issue I was seeing so I think the patch is no longer needed.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?h=i2c/for-next&id=e1ab9a468e3b1

---
Best Regards, Laurentiu
