From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add support for the S-35390A RTC chip.
Date: Sun, 6 Jan 2008 14:25:37 -0800
Message-ID: <200801061425.38412.david-b@pacbell.net>
References: <1199573894-9189-1-git-send-email-byron.bbradley@gmail.com>
	<20080106190100.5e7b6be9@hyperion.delvare>
	<57e2b00801061411g4d5280deg4bc9f8dc4c8bce8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <57e2b00801061411g4d5280deg4bc9f8dc4c8bce8b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Byron Bradley <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 06 January 2008, Byron Bradley wrote:
> David, the ENOCSI comment probably applies to your at24 eeprom driver
> too. I was wondering why that error code was chosen since other than
> "No CSI structure available" I couldn't find anything about it.

It was chosen for its uniqueness ... ideally each fault path has its
own fault code and (possibly debug-only) diagnostic.  When you get
a fault code from a driver, and there's only one place that's used,
it's a lot easier to know what went wrong than if the fault code is
(over)used in many places.

In fact it's common practice to adopt subsystem-specific conventions
about what a given errno value indicates.  Otherwise, almost every
fault observed would map to a small handful ... making them useless
for fault recovery logic, and at best problematic in terms of any
diagnostic utility.

- Dave
