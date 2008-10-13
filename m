From: BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2.6.26.5] rtc-ds1307 : SMBus compatibility
Date: Mon, 13 Oct 2008 16:55:53 +0200
Message-ID: <C1C62166118DFA4A8BBA01A2411F0D170E9BE5A1BF@PRI-MBX-101.dom1.vinci-energies.net>
References: <C1C62166118DFA4A8BBA01A2411F0D170E9BE59E27@PRI-MBX-101.dom1.vinci-energies.net>
	<20081010133344.653431af@hyperion.delvare>
	<200810112150.21370.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200810112150.21370.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: frederic Rodo <f.rodo-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]
...
> At a quick glance, this looks like a sane conversion ... unlike the
> last
> one proposed, which I had to NAK since it broke driver functionality by
> trying to replace block transfers with non-equivalent byte-at-a-time
> ones.
> (Clock updates between bytes, boom!)

Sorry, I don't understand what you talk about.
The i2c_smbus_read_i2c_block_data function do block transfer not byte-at-a-=
time one. Doesn't it ?
