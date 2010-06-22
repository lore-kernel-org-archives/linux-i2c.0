From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] i2c: davinci: Fix race when setting up for TX
Date: Tue, 22 Jun 2010 17:47:59 +0530
Message-ID: <41914.2560022466$1277209387@news.gmane.org>
References: <1277191864-5024-1-git-send-email-jon.povey@racelogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1277191864-5024-1-git-send-email-jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
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
To: 'Jon Povey' <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: "'Jean Delvare (PC drivers, core)'" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, 'Philby John' <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "'Ben Dooks (embedded platforms)'" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Jun 22, 2010 at 13:01:03, Jon Povey wrote:
> Move the interrupt enable after the first byte load for TX, as it
> was racing with the interrupt handler and corrupting dev->buf_len
> for messages > 1 byte.
> 
> Tested on DM355.
> 
> Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
> ---
> The race seems to have been introduced by 869e6692d527983958216f13c3c8e095791909df
> 
> This fixes the problem for me, but someone from TI might want to comment
> on the validity of starting the transfer before enabling the RDY interrupts.
> Any possibility of losing interrupts?
> 

This fix can cause interrupts to be missed as there will be a race between
writing to DXR and setting of interrupts. I think you can decrement dev->buf_len
before writing to DXR register. This should resolve the original race condition
which you had encountered.

Regards,
Sudhakar
