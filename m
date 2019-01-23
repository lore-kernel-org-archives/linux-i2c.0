From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] i2c: imx: fix inconsistent IS_ERR and PTR_ERR
Date: Wed, 23 Jan 2019 02:55:39 -0600
Message-ID: <5a0aaed8-adf6-b730-990a-5092538cfe68@embeddedor.com>
References: <20190123003741.GA12068@embeddedor> <20190123082849.GA1129@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123082849.GA1129@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org



On 1/23/19 2:28 AM, Wolfram Sang wrote:
> On Tue, Jan 22, 2019 at 06:37:41PM -0600, Gustavo A. R. Silva wrote:
>> Fix inconsistent IS_ERR and PTR_ERR in i2c_imx_dma_request.
>>
>> The proper pointer to be passed as argument is dma->chan_tx.
>>
>> This bug was detected with the help of Coccinelle.
>>
>> Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx_dma_request")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I pushed a similar fix to linux-next yesterday.
> 

Great. Good to know it is fixed now. :)

Thanks
--
Gustavo
