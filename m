From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: MPC8349E-mITX Power Management and GPIO
	expander driver
Date: Fri, 10 Oct 2008 09:58:44 -0500
Message-ID: <CB31A54E-7518-4E26-8A5C-AC3CBB0F1384@kernel.crashing.org>
References: <20080923141300.GB31262@oksana.dev.rtsoft.ru>
	<683C10AE-E5F2-4196-B2C7-1E1CC317EC24@kernel.crashing.org>
	<20081010144545.GA956@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081010144545.GA956-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Oct 10, 2008, at 9:45 AM, Anton Vorontsov wrote:

> On Fri, Oct 10, 2008 at 09:22:02AM -0500, Kumar Gala wrote:
>>
>> On Sep 23, 2008, at 9:13 AM, Anton Vorontsov wrote:
>>
>>> On MPC8349E-mITX, MPC8315E-RDB and MPC837x-RDB boards there is a
>>> Freescale MC9S08QG8 (MCU) chip with the custom firmware
>>> pre-programmed. The chip is used to power-off the board by the
>>> software, and to control some GPIO pins.
>>>
>>> Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
>>> ---
>>> drivers/i2c/chips/Kconfig            |   11 ++
>>> drivers/i2c/chips/Makefile           |    1 +
>>> drivers/i2c/chips/mcu_mpc8349emitx.c |  209 +++++++++++++++++++++++ 
>>> ++
>>> +++++++++
>>> 3 files changed, 221 insertions(+), 0 deletions(-)
>>> create mode 100644 drivers/i2c/chips/mcu_mpc8349emitx.c
>>
>> is the plan to connect ppc_md.machine_shutdown() with this?
>
> You mean poweroff? It's already connected.
>
> +       /* XXX: this is potentially racy, but there is no lock for  
> ppc_md */
> +       if (!ppc_md.power_off) {
> +               glob_mcu = mcu;
> +               ppc_md.power_off = mcu_power_off;
> +               dev_info(&client->dev, "will provide power-off  
> service\n");
> +       }


uuh, yeah.. poweroff :)

and look at that.  Is this in Jean's queue?

- k

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
