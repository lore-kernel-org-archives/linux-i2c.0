From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv11 1/6] i2c: omap: Optimise the remove code
Date: Fri, 13 Jul 2012 16:51:32 +0530
Message-ID: <500004BC.1060403@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com> <1340896292-12112-2-git-send-email-shubhrajyoti@ti.com> <20120712121857.GA2194@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120712121857.GA2194@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com
List-Id: linux-i2c@vger.kernel.org

On Thursday 12 July 2012 05:48 PM, Wolfram Sang wrote:
> On Thu, Jun 28, 2012 at 08:41:27PM +0530, Shubhrajyoti D wrote:
>> The omap_i2c_remove function may not be needed after
>> device exit so the memory could be freed.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Changed the title from "optimise" to "annotate" and pushed to next.
Thanks for fixing that.
>

