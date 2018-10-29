From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v1 3/3] i2c: imx: don't print error if DMA is not
 configured
Date: Mon, 29 Oct 2018 09:07:56 +0100
Message-ID: <9a3fc087-2fe5-6d57-9b65-a05e176bf53d@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-4-o.rempel@pengutronix.de>
 <20181028221123.GE1882@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181028221123.GE1882@kunai>
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
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org



On 28.10.18 23:11, Wolfram Sang wrote:
> On Thu, Oct 18, 2018 at 01:26:15PM +0200, Oleksij Rempel wrote:
>> At least on i.MX5x variants is DMA event for I2C muxed with SDHC. So
>> it is project specific configuration and not an error.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> So, the first patch is not I2C realm, and the second is dropped. No
> comment about the third one?
> 
> And is maybe someone from Pengutronix interested in maintaining this
> driver? Uwe maybe? That would speed up things for it...

Should i resend it as single patch?
