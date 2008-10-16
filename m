From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2.6.26.5] rtc-ds1307 : SMBus compatibility
Date: Thu, 16 Oct 2008 11:06:01 -0700
Message-ID: <200810161106.02871.david-b@pacbell.net>
References: <C1C62166118DFA4A8BBA01A2411F0D170E9BE59E27@PRI-MBX-101.dom1.vinci-energies.net>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BE5A317@PRI-MBX-101.dom1.vinci-energies.net>
	<20081014184038.6f1b5c59@i1501.lan.towertech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081014184038.6f1b5c59-1Z+4F8PJzVxlecnr3/Sf3RLwuzhV/fVh@public.gmane.org>
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
To: Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
Cc: frederic Rodo <f.rodo-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, "i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 14 October 2008, Alessandro Zummo wrote:
> On Tue, 14 Oct 2008 17:57:29 +0200
> BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > >  seems almost ok. please send your latest version to me and cc to
> > >  the rtc-list for the final review. if it passed Jean's tests
> > >  I'm confident it's quite ready for inclusion :)
> > 
> > Patch is attached to preserve tabs.
> 
>  bzzzt. wrong! patches must be submitted inline

Though that's not a hard-and-fast policy; when
the submitter can't get relevant mailers to avoid
mangling the patches, it's better to attach them
than otherwise.  However, see

  Documentation/email-clients.txt

More generally, this patch isn't much good since
it doesn't even *apply* ... on top of a pending
patch to the same driver, which has been in the
MM tree since late July or so.

My suggestion:  since that patch was recently
(last night) sent to Linus for merging, wait
until it's in mainline GIT.  Then refresh and
re-send the patch.

- Dave


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
