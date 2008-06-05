From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 10:59:55 -0400
Message-ID: <9e4733910806050759y2f8f2c0av98404f8f2d628bd9@mail.gmail.com>
References: <20080604201334.19636f30@hyperion.delvare>
	<9e4733910806041155n7551ac74lf29c8a32163ec09a@mail.gmail.com>
	<9e4733910806041228i330e145q439d3ee43494f4c4@mail.gmail.com>
	<20080604233335.13459512@hyperion.delvare>
	<9e4733910806041611l41832e07p4f55424be0ef5ea0@mail.gmail.com>
	<20080605110502.76f0f606@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080605110502.76f0f606-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 6/5/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Care to enlighten me on what this other way would be? It's easy to
>  claim this of pretty much everything, but that's not valuable without
>  details on the "other way", sorry.

I'm just proposing optimizations to the scheme, we are in agreement on
the core of the proposal.  Let's go ahead with the way you proposed
(with it moved to i2c_driver). Then after you get everything working
with the new scheme I'll see if I can add optimizations to remove some
of the entry points. It is more important to get the old to new driver
conversion going.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
