From: Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
Subject: Re: [PATCH 2.6.26.5] rtc-ds1307 : SMBus compatibility
Date: Tue, 14 Oct 2008 15:22:02 +0200
Message-ID: <20081014152202.4a88920a@i1501.lan.towertech.it>
References: <C1C62166118DFA4A8BBA01A2411F0D170E9BE59E27@PRI-MBX-101.dom1.vinci-energies.net>
	<20081010133344.653431af@hyperion.delvare>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BE5A032@PRI-MBX-101.dom1.vinci-energies.net>
	<20081013173206.6b7a5e1e@hyperion.delvare>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BE5A2DA@PRI-MBX-101.dom1.vinci-energies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <C1C62166118DFA4A8BBA01A2411F0D170E9BE5A2DA-iGzfJtNnmHkUlixSki3fykIJAyBIbWHDnAJcWxkt5PDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, David-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org, Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, frederic Rodo <f.rodo-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>, "i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 14 Oct 2008 15:15:10 +0200
BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org> wrote:

>  Note: you need to include a comment describing what your patch does,
> > as well as your Signed-off-by line. Here's a second review from me.
> > After that it will be up to Alessandro and the RTC folks.
> >  
> 
> So I'm waiting for their comments.

 seems almost ok. please send your latest version to me and cc to
 the rtc-list for the final review. if it passed Jean's tests
 I'm confident it's quite ready for inclusion :)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
