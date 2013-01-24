From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] i2c: at91: add of_device_id entry for at91rm9200
Date: Thu, 24 Jan 2013 11:44:04 +0100
Message-ID: <51011074.1020905@atmel.com>
References: <1354743732-11581-1-git-send-email-manabian@gmail.com>
 <20121218060232.GL23971@game.jcrosoft.org>
 <20130124072714.GH8364@nekote.pengutronix.de> <5100E9A4.9020804@atmel.com>
 <20130124101356.GA12933@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130124101356.GA12933@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Joachim Eastwood <manabian@gmail.com>, nicolas.ferre@atmel.com, "ludovic.desroches" <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 01/24/2013 11:13 AM, Wolfram Sang wrote:
> Hi,
>
>> I didn't add this when I did the rework because there was no DT tree
>> support for RM9200. The configuration for RM9200 IP is already in
>> the driver and used for non DT platform so I think it makes sense to
>> add this.
>
> I agree. If it is usable for non-dt, it should be usable for dt. If it
> makes sense is left to the user.
>
> Interpreted Ludovic's comment as ack and applied to -next, thanks!
>

Yes it is, thanks.

Regards

Ludovic
