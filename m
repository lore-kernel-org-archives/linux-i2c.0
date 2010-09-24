From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4] i2c: davinci: Fix race when setting up for TX
Date: Fri, 24 Sep 2010 10:12:07 +0530
Message-ID: <7119.30500478974$1285303716@news.gmane.org>
References: <4C97CEC9.8060602@boundarydevices.com>
	<1285042408-13200-1-git-send-email-jon.povey@racelogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1285042408-13200-1-git-send-email-jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
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
To: 'Jon Povey' <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 21, 2010 at 09:43:28, Jon Povey wrote:
> When setting up to transmit, a race exists between the ISR and
> i2c_davinci_xfer_msg() trying to load the first byte and adjust counters.
> This is mostly visible for transmits > 1 byte long.
> 
> The hardware starts sending immediately that MDR.STT is set. IMR trickery
> doesn't work because if we start sending, finish the first byte and an
> XRDY event occurs before we load IMR to unmask it, we never get an
> interrupt, and we timeout.
> 
> Sudhakar Rajashekhara explains that at least OMAP-L138 requires MDR mode
> settings before DXR for correct behaviour, so load MDR first with
> STT cleared and later load again with STT set.
> 
> Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985
> 
> Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
> CC: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> CC: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> ---

Tested-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>

Tested with audio loopback on OMAP-L138, OMAP-L137 and DM365. Also tested with
i2cdetect function which probes all the devices on the i2c bus.

Thanks,
Sudhakar
