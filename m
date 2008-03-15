From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATH 0/3] isp1301 changes
Date: Sat, 15 Mar 2008 16:28:32 +0100
Message-ID: <20080315162832.067b8088@hyperion.delvare>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1205585237-21492-1-git-send-email-me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, David Brownell <david-b-ZKR15rr3LjGsTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 15 Mar 2008 14:47:14 +0200, Felipe Balbi wrote:
> Hi Jean,
> 
> I have a new approach for the isp1301 driver, took your idea
> of adding a new irq_flags member to i2c_boardinfo and i2c_client.

I said we could do this _if_ many drivers needed this field. I didn't
mean to do it right now... So far I only know of the isp1301 driver
which would need this. And at any rate I'd like to hear David's opinion
before adding a new field to the core i2c structures.

> If it's ok for you, i'll also send a patch putting linux-omap and
> linux-mailine isp1301 in sync.

This would be great, yes. Divergence between trees tend to confuse
developers, often I receive patches which do not apply to my tree
because of this.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
