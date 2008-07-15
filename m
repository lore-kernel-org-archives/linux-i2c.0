From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 1/1] i2c_gpio: keep probe resident for hotplugged
 devices.
Date: Tue, 15 Jul 2008 13:36:55 +0200
Message-ID: <20080715133655.18a95247@siona.local>
References: <20080702101611.757880819@fluff.org>
	<20080702101611.858837181@fluff.org>
	<20080702124406.2f3d1384@hskinnemo-gx745.norway.atmel.com>
	<20080710132917.GF30539@fluff.org.uk>
	<20080712090600.680f3c2e@hyperion.delvare>
	<20080715094147.GI30539@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080715094147.GI30539-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 15 Jul 2008 10:41:47 +0100
Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:

> I'll take it, I was just waiting to see if there
> where any more objections from Haavard before applying
> this.
> 
> If i've not received an objection by 0900GMT 2008-07-16
> then I will add it to my rather small git tree and ask
> linus to pull.

Ok, you won't receive any, so feel free to do that right away :-)

I was just curious about the reason why you need to support hotplugging,
and a bit slow to respond since I'm mostly offline these days.

Haavard

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
