From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/5] I2C: DaVinci: fix signal handling bug
Date: Tue, 29 Apr 2008 10:08:05 +0200
Message-ID: <20080429100805.7f8208ed@hyperion.delvare>
References: <1209142694-30046-1-git-send-email-troy.kisky@boundarydevices.com>
	<1209142694-30046-2-git-send-email-troy.kisky@boundarydevices.com>
	<1209142694-30046-3-git-send-email-troy.kisky@boundarydevices.com>
	<1209142694-30046-4-git-send-email-troy.kisky@boundarydevices.com>
	<20080428191332.371e35e3@hyperion.delvare>
	<48161578.3080000@boundarydevices.com>
	<20080428225011.4d97736c@hyperion.delvare>
	<4816608B.2000001@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4816608B.2000001-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Troy,

On Mon, 28 Apr 2008 16:40:59 -0700, Troy Kisky wrote:
> Jean Delvare wrote:
> > On Mon, 28 Apr 2008 11:20:40 -0700, Troy Kisky wrote:
> >> Do you want it changed to use wait_for_completion_timeout()?
> > 
> > I'm suggesting this because it seems to be a much more simple way to
> > fix the problem. If that works for you, why do something more complex?
> 
> IMHO, if an i2c interrupt happens that says data is available to
> read, that data should be read, regardless of whether or not we expected
> data to be available. So, the ^c bug just nudged me to change it.
> But my stance is not firm, let me know your preference.

I have no preference. If you think that handling the signals the way
you first proposed is the way to go, that's fine with me. But then you
have to add comments to explain what you are doing, as suggested in my
original review.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
