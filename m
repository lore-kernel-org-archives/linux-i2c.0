From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Mon, 23 Jun 2008 09:14:06 +0200
Message-ID: <20080623091406.2a68e9d1@hyperion.delvare>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080622085206.GM10695-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Rodolfo,

On Sun, 22 Jun 2008 10:52:06 +0200, Rodolfo Giometti wrote:
> On Sun, Jun 22, 2008 at 10:37:16AM +0200, Peter Korsgaard wrote:
> > >>>>> "Rodolfo" == Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org> writes:
> > 
> > Hi,
> > 
> >  Rodolfo> +
> >  Rodolfo> +struct i2c_adapter *i2c_add_virt_adapter(struct i2c_adapter *parent,
> >  Rodolfo> +				struct i2c_client *client,
> >  Rodolfo> +				u32 force_nr, u32 mux_val,
> >  Rodolfo> +				int (*select_cb) (struct i2c_adapter *,
> >  Rodolfo> +						struct i2c_client *, u32),
> >  Rodolfo> +				int (*deselect_cb) (struct i2c_adapter *,
> >  Rodolfo> +						struct i2c_client *, u32))
> >  Rodolfo> +{
> > 
> > How about changing the struct i2c_client to an anonymous void *data
> > instead so it can be used for systems where the multiplexing hardware
> > isn't a i2c device? E.G. I have a driver (currently not in mainline)
> > for a I2C multiplexer implemented in a FPGA together with the
> > opencores I2C controller:
> > [snip] 
> > It would be nice to be able to use the i2c-virtual stuff for it.
> 
> Mmm... I suppose is not so easy as we wish since there are several
> references to the i2c parent struct into the code.
> 
> I suppose you can get better result if you define your i2c multiplexer
> as a dummy i2c device. The you can force it to be connected with a
> real i2c parent by using the i2c_register_board_info() function.

Don't even think about it. We've done dummy i2c devices before and it
took me 3 years to clean up the mess. Not again, please.

Peter is totally right, there's no reason why I2C multiplexers would
always be I2C devices themselves (and when they are, they do not have
to live on the bus they are multiplexing, even though this is the most
frequent case). That's only one of the possible cases. The core i2c
multiplexing code shouldn't assume anything about the nature of the
multiplexer, that's something for the actual implementation of specific
multiplexer drivers to deal with.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
