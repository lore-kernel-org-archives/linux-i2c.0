From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v2] i2c: i2c-stm32f7: fix no check on returned setup
Date: Thu, 22 Mar 2018 09:33:26 +0100
Message-ID: <f6763dfd-9535-1206-fed0-a611b9ea81b7@st.com>
References: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, Wolfram Sang <wsa@the-dreams.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org



On 03/21/2018 05:48 PM, Pierre-Yves MORDRET wrote:
> Before assigning returned setup structure check if not null
> 
> Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>       v1:
>           * Initial
>       v2:
>           * fill "ret" with error statement before go to "clk_free"
> ---
> ---
>   drivers/i2c/busses/i2c-stm32f7.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index b445b3b..f273e28 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -888,6 +888,11 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>   	}
>   
>   	setup = of_device_get_match_data(&pdev->dev);
> +	if (!setup) {
> +		dev_err(&pdev->dev, "Can't get device data\n");
> +		ret = -ENODEV;
> +		goto clk_free;
> +	}
>   	i2c_dev->setup = *setup;
>   
>   	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-rising-time-ns",
> 
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
