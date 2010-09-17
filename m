From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3] i2c: davinci: Fix race when setting up for TX
Date: Fri, 17 Sep 2010 18:39:56 +0530
Message-ID: <12552.912758156$1284729382@news.gmane.org>
References: <1284691607-9697-1-git-send-email-jon.povey@racelogic.co.uk>
	<1284692531-10100-1-git-send-email-jon.povey@racelogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1284692531-10100-1-git-send-email-jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: 'Jon Povey' <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Fri, Sep 17, 2010 at 08:32:11, Jon Povey wrote:
> When setting up to transmit, a race exists between the ISR and
> i2c_davinci_xfer_msg() trying to load the first byte and adjust counters.
> This is mostly visible for transmits > 1 byte long.
> 
> The hardware starts sending immediately that MDR is loaded. IMR trickery
> doesn't work because if we start sending, finish the first byte and an
> XRDY event occurs before we load IMR to unmask it, we never get an
> interrupt, and we timeout.
> 
> Move the MDR load after DXR,IMR loads to avoid this race without locking.
> 
> Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985
> 

I remember I had some issues on OMAP-L138 with this fix, that's when I
reverted to configuring ICMDR before writing to DXR (Please see here:
https://patchwork.kernel.org/patch/75262/). I checked the BIOS I2C
driver code for OMAP-L138 and there also we are configuring MDR before
accessing DXR.

Regards,
Sudhakar
