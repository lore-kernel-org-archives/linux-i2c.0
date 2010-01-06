From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v3 0/4] i2c: davinci: Add power management features
Date: Wed, 06 Jan 2010 07:24:01 -0800
Message-ID: <871vi3ntny.fsf@deeprootsystems.com>
References: <1262769900-2710-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1262769900-2710-1-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org> (Chaithrika
	U. S.'s message of "Wed\, 6 Jan 2010 14\:54\:56 +0530")
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org> writes:

> Add suspend/resume and cpufreq features to DaVinci I2C driver
> All patches apply to Linus' kernel tree.
> Testing of these features was done on DA850/OMAP-L138 EVM.
>
> Chaithrika U S (4):
>   i2c: davinci: Remove MOD_REG_BIT and IO_ADDRESS usage
>   i2c: davinci: Add helper functions
>   i2c: davinci: Add suspend/resume support
>   i2c: davinci: Add cpufreq support
>
>  drivers/i2c/busses/i2c-davinci.c |  228 ++++++++++++++++++++++++++++---------
>  1 files changed, 172 insertions(+), 56 deletions(-)
>
> In this version, the suspend/resume support patch has been updated to
> use dev_pm_ops.

Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>

Ben, please queue this series for 2.6.34.

Thanks,

Kevin
