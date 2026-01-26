Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99330275F
	for <linux-i2c@vger.kernel.org>; Mon, 26 Jan 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418784; cv=pass; b=WZaihZgkWidLj2kwLssVQtxqT1qAphuNpwzkEgujoYgDTS2wzvAvrJH5MW+TwfEmXT/6IfsF7Ej6eEL0VE0qlif+qdLItY5iaEG1tngqvRNHdIBHxZDbOP02xATfj8JeBj76TX4YPuBzV00/misUKM8M4fq6WtebS1qq56YFfxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418784; c=relaxed/simple;
	bh=Wo/vQPz+0V8LDd9oV6OYeXAtWjk9LyHablfez9LuH8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lORCCn9LfhuL/zkNNqxP2sxBPCq0OY6TAEDRyhP9w/0boAamb0419DxXpnlY53pi0y2plEAYfAGUHF65z+qgGqlyh8CHohPIc3G2LAay1D0+m3q+UH2KXMdZL4Uayy6rhOoivqs57Nr0M8UrznLYLWh+LyJPSj2Tg6CVi6CPhOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mdOdYjhB; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mdOdYjhB"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so5871449a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 26 Jan 2026 01:13:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769418781; cv=none;
        d=google.com; s=arc-20240605;
        b=CUyRw0GVVbVw1zgSx6m4QsrEtK1tuDR8gyXvNOmY6ZZQ3SRslhiGdfjzI3UIGwTpEd
         vW4PMGB+ZXYL4vD7EAjTDBDpu61HM+KYtO/kUJNqv1JvbEVTDJha0XFT/0qApIG57RaG
         jmrXKWpBtwLelcpM6iJYgpxMq1RmA/jUWuVzDDVMYHyUEOO+JncArUC98vfLHjPAs0Mw
         KRGt5EAly2433f9qT2UNniw2io4Jf/AAVDzUzgk5tKpdD39dBszZCcecIFII+2v64f89
         XGaqcomSO2cPukbKt3yYTk/UtjE9NEchxqcE2zfGxZWBJOA+KpewxAHdlAWaghzBe97A
         DyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=38F1GYV0XN/PxaeV/i4/kx4eQmWmLGFD/ba5srNlENw=;
        fh=nlxG5T+LgI9468QhHsKm5sZp7PoAPi7+xdjyRBQC97I=;
        b=KR56gMIy2pwROf7tgk42j5AnyDN3VXvHAd1elOsWzf0zpyCWNCUsJWukzkyIeKFM6O
         K2PNCd1mOK0udmP6DNPTFkK0Hc4ABJcD8Nub5+tNFX03aD1YC6aU/W1DeBwyqFNvmEo4
         2/M9qZXgWK/FJgQ1/za21DwygqFjtpAwpKCzn3J6GS98xT20Eu65KIJhKWpwzpbOsa1+
         m33OzfQSBPC91lTRzF2otf05rgU9SvfDhV/uiKwJKHS2mptANeFWRTJGOUNiRmUiH3Yl
         +4D7EvJOK7AJWRTBfxgiLrS03oLOa8iTYx5UgaLZaE8Xa4YlBGilX2UUZVLLFclu4omB
         5qPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1769418781; x=1770023581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38F1GYV0XN/PxaeV/i4/kx4eQmWmLGFD/ba5srNlENw=;
        b=mdOdYjhBQN+aJT68cRff7fe8X1jgC+0RQsVrgGZeUSVa9ZRpdqx1dEtl8uX7BNpx/U
         HnD42uJ877sAvKkRfQ51yJPC8mbosbwaXxGoVCqihXdfFiTUYWTBFf3xKVI6+dTyLIsp
         WC9JN1achyXKf+XKZo9CSMQRjY5Sm9MMAoUEo/rcl1nTQ8HZjhPV0ojqpKEL/B4paIrZ
         LzdSRjK9l6rs6ypTFQQtz6+uJftsMlf3eQIQ/YgzFlzphLyFGPPn44wtt8DywbJFZviX
         k2CZ1szqpy71jNDV/Rf+LDs/Dxq/Hxi5T5uhDHoF++uZJJQJlhPwOffIHmqDB0cV9PJt
         2MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769418781; x=1770023581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38F1GYV0XN/PxaeV/i4/kx4eQmWmLGFD/ba5srNlENw=;
        b=kw+fN+ReqTOUaBijBtpaf8rBLvQ99Ws6RfpGE/EdiOgEF2XmfeXYh+eZekSlMkyrDJ
         Taj5e7VZxtaAmGRkqhbu4fjAttyRJBmmSgTVQvd56p4DQrIz1VgU9yh6NjJ63ZQDLMcj
         jB9xMKw9ddu/J0E8KrbAQbJM0iBVqRcYflJa0ECR6Q4Ua6Ac84gE+jJS/3YWL7T2JkV8
         CygLqXYB7OO0bBGAP5un/JJyg7PjJTATFgatBKoHC2FGYaTVzygT4lifm+4QWSY6tx1f
         3n6pbCxATYJL00OXR0feDHzXQVZKno56hnuSghup7lXRaZN96vefd3OKPuSMDhRQOXFZ
         7DAg==
X-Forwarded-Encrypted: i=1; AJvYcCXH7eO/qpN5/PjyTEp2OBVR1Yex0sK5s22EFo631YHSrDeBZ0/tx7EnCZ161fdSGz25e/j4UI7ABb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyMvmLWdud4kkVlPnz7d648M6DJgIonZVDjZw279+nvJGeTUo
	WN99FZ0hN84zPtshCKKbJR/C0LHRa+svZC15Zk/N+aUYhQkbgHfMBYAd59hA5k/8Tniu+y3uYrq
	QZVRPFRoJI1bYY39QRCfVlWj+DKu/UG/9g5P2btMfWw==
X-Gm-Gg: AZuq6aIC0cvNXxfHpxjf31Qyn77ZSXk1Sl1OUpI28+lHV7XvqMvgb6oF0YIiL+FLLS+
	2HgktqOADQnEy72d8TO61eHXdwLE/DSMd6oKchyQpDVotAE9gr/RuL5SHfdjLB1P6e8+M4fvGbT
	SDTB0SMyS2OF/xvp1jU73IC6UXOJQTV8vcmkfyLjC/RNkl2rfuQf7mZloqf6+KDGDYWFV/HTnny
	iovEy5VWC5ArGeGT2wTjS17KX28XIO+c5nF4MJspsOhECAMfLMbz44Qpcna89PLFhTMtIh/T1+E
	Bonx2Z+k3MMvGO8fqGSZOTuKDBiyJQ8mAQIoyh3i4wngZw6cxjU=
X-Received: by 2002:a17:907:3cc6:b0:b87:e75:92e3 with SMTP id
 a640c23a62f3a-b8cfedfbb3cmr291271166b.4.1769418780434; Mon, 26 Jan 2026
 01:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-i2c-pxa-fix-i2c-communication-v3-0-052c9b1966a2@gmail.com>
 <20250827-i2c-pxa-fix-i2c-communication-v3-2-052c9b1966a2@gmail.com>
In-Reply-To: <20250827-i2c-pxa-fix-i2c-communication-v3-2-052c9b1966a2@gmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 26 Jan 2026 10:12:49 +0100
X-Gm-Features: AZwV_QjbdS2c5gKFf7G1ps0B7bA9mX_zUUwnEF3cB_N_luca8ANmVfGDdft_W_U
Message-ID: <CA+HBbNE9yKj6pnZZm3m_+vsUjOvMPtuQQJ2SjZ9XSgvBf0n0Kw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] i2c: pxa: handle 'Early Bus Busy' condition on
 Armada 3700
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Wolfram Sang <wsa@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Hanna Hawa <hhhawa@amazon.com>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:14=E2=80=AFPM Gabor Juhos <j4g8y7@gmail.com> wrot=
e:
>
> Under some circumstances I2C recovery fails on Armada 3700. At least
> on the Methode uDPU board, removing and replugging an SFP module fails
> often, like this:
>
>   [   36.953127] sfp sfp-eth1: module removed
>   [   38.468549] i2c i2c-1: i2c_pxa: timeout waiting for bus free
>   [   38.486960] sfp sfp-eth1: module MENTECHOPTO      POS22-LDCC-KR    r=
ev 1.0  sn MNC208U90009     dc 200828
>   [   38.496867] mvneta d0040000.ethernet eth1: unsupported SFP module: n=
o common interface modes
>   [   38.521448] hwmon hwmon2: temp1_input not attached to any thermal zo=
ne
>   [   39.249196] sfp sfp-eth1: module removed
>   ...
>   [  292.568799] sfp sfp-eth1: please wait, module slow to respond
>   ...
>   [  625.208814] sfp sfp-eth1: failed to read EEPROM: -EREMOTEIO
>
> Note that the 'unsupported SFP module' messages are not relevant. The
> module is used only for testing the I2C recovery funcionality, because
> the error can be triggered easily with this specific one.
>
> Enabling debug in the i2c-pxa driver reveals the following:
>
>   [   82.034678] sfp sfp-eth1: module removed
>   [   90.008654] i2c i2c-1: slave_0x50 error: timeout with active message
>   [   90.015112] i2c i2c-1: msg_num: 2 msg_idx: 0 msg_ptr: 0
>   [   90.020464] i2c i2c-1: IBMR: 00000003 IDBR: 000000a0 ICR: 000007e0 I=
SR: 00000802
>   [   90.027906] i2c i2c-1: log:
>   [   90.030787]
>
> This continues until the retries are exhausted ...
>
>   [  110.192489] i2c i2c-1: slave_0x50 error: exhausted retries
>   [  110.198012] i2c i2c-1: msg_num: 2 msg_idx: 0 msg_ptr: 0
>   [  110.203323] i2c i2c-1: IBMR: 00000003 IDBR: 000000a0 ICR: 000007e0 I=
SR: 00000802
>   [  110.210810] i2c i2c-1: log:
>   [  110.213633]
>
> ... then the whole sequence starts again ...
>
>   [  115.368641] i2c i2c-1: slave_0x50 error: timeout with active message
>
> ... while finally the SFP core gives up:
>
>   [  671.975258] sfp sfp-eth1: failed to read EEPROM: -EREMOTEIO
>
> When we analyze the log, it can be seen that bit 1 and 11 is set in the
> ISR (Interface Status Register). Bit 1 indicates the ACK/NACK status, but
> the purpose of bit 11 is not documented in the driver code unfortunately.
>
> The 'Functional Specification' document of the Armada 3700 SoCs family
> however says that this bit indicates an 'Early Bus Busy' condition. The
> document also notes that whenever this bit is set, it is not possible to
> initiate a transaction on the I2C bus. The observed behaviour corresponds
> to this statement.
>
> Unfortunately, I2C recovery does not help as it never runs in this
> special case. Although the driver checks the busyness of the bus at
> several places, but since it does not consider the A3700 specific bit
> in these checks it can't determine the actual status of the bus correctly
> which results in the errors above.
>
> In order to fix the problem, add a new member to struct 'i2c_pxa' to
> store a controller specific bitmask containing the bits indicating the
> busy status, and use that in the code while checking the actual status
> of the bus. This ensures that the correct status can be determined on
> the Armada 3700 based devices without causing functional changes on
> devices based on other SoCs.
>
> With the change applied, the driver detects the busy condition, and runs
> the recovery process:
>
>   [  742.617312] i2c i2c-1: state:i2c_pxa_wait_bus_not_busy:449: ISR=3D00=
000802, ICR=3D000007e0, IBMR=3D03
>   [  742.626099] i2c i2c-1: i2c_pxa: timeout waiting for bus free
>   [  742.631933] i2c i2c-1: recovery: resetting controller, ISR=3D0x00000=
802
>   [  742.638421] i2c i2c-1: recovery: IBMR 0x00000003 ISR 0x00000000
>
> This clears the EBB bit in the ISR register, so it makes it possible to
> initiate transactions on the I2C bus again.
>
> After this patch, the SFP module used for testing can be removed and
> replugged numerous times without causing the error described at the
> beginning. Previously, the error happened after a few such attempts.
>
> The patch has been tested also with the following kernel versions:
> 5.10.240, 5.15.189, 6.1.148, 6.6.102, 6.12.42, 6.14.11, 6.15.10, 6.16.1
> It improves recovery on all of them.
>
> Cc: stable@vger.kernel.org # 5.10+
> Reviewed-by: Imre Kaloz <kaloz@openwrt.org>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Tested-by: Robert Marko <robert.marko@sartura.hr>

> Changes in v3:
>   - rebase on tip of i2c/for-current
>   - use Reviewed-by tag for Imre
>   - remove Fixes tag as the problem is not caused by the previously menti=
oned
>     commit, simply it is not handled by the code yet
>   - update list of tested kernels
>   - Link to v2: https://lore.kernel.org/r/20250811-i2c-pxa-fix-i2c-commun=
ication-v2-3-ca42ea818dc9@gmail.com
>
> Changes in v2:
>   - rebase and retest on tip of i2c/for-current
>   - Link to v1: https://lore.kernel.org/r/20250511-i2c-pxa-fix-i2c-commun=
ication-v1-3-e9097d09a015@gmail.com
> ---
>  drivers/i2c/busses/i2c-pxa.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 70acf33e1d573231f84a1f09cffb376a8277351d..19f5da08def11ded1d3de968f=
50fa5b5851066f5 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -71,6 +71,7 @@
>  #define ISR_GCAD       (1 << 8)           /* general call address detect=
ed */
>  #define ISR_SAD                (1 << 9)           /* slave address detec=
ted */
>  #define ISR_BED                (1 << 10)          /* bus error no ACK/NA=
K */
> +#define ISR_A3700_EBB  (1 << 11)          /* early bus busy for armada 3=
700 */
>
>  #define ILCR_SLV_SHIFT         0
>  #define ILCR_SLV_MASK          (0x1FF << ILCR_SLV_SHIFT)
> @@ -263,6 +264,7 @@ struct pxa_i2c {
>         bool                    highmode_enter;
>         u32                     fm_mask;
>         u32                     hs_mask;
> +       u32                     busy_mask;
>
>         struct i2c_bus_recovery_info recovery;
>         struct pinctrl          *pinctrl;
> @@ -430,7 +432,7 @@ static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *=
i2c)
>
>         while (1) {
>                 isr =3D readl(_ISR(i2c));
> -               if (!(isr & (ISR_IBB | ISR_UB)))
> +               if (!(isr & i2c->busy_mask))
>                         return 0;
>
>                 if (isr & ISR_SAD)
> @@ -467,7 +469,7 @@ static int i2c_pxa_wait_master(struct pxa_i2c *i2c)
>                  * quick check of the i2c lines themselves to ensure they=
've
>                  * gone high...
>                  */
> -               if ((readl(_ISR(i2c)) & (ISR_UB | ISR_IBB)) =3D=3D 0 &&
> +               if ((readl(_ISR(i2c)) & i2c->busy_mask) =3D=3D 0 &&
>                     readl(_IBMR(i2c)) =3D=3D (IBMR_SCLS | IBMR_SDAS)) {
>                         if (i2c_debug > 0)
>                                 dev_dbg(&i2c->adap.dev, "%s: done\n", __f=
unc__);
> @@ -488,7 +490,7 @@ static int i2c_pxa_set_master(struct pxa_i2c *i2c)
>         if (i2c_debug)
>                 dev_dbg(&i2c->adap.dev, "setting to bus master\n");
>
> -       if ((readl(_ISR(i2c)) & (ISR_UB | ISR_IBB)) !=3D 0) {
> +       if ((readl(_ISR(i2c)) & i2c->busy_mask) !=3D 0) {
>                 dev_dbg(&i2c->adap.dev, "%s: unit is busy\n", __func__);
>                 if (!i2c_pxa_wait_master(i2c)) {
>                         dev_dbg(&i2c->adap.dev, "%s: error: unit busy\n",=
 __func__);
> @@ -514,7 +516,7 @@ static int i2c_pxa_wait_slave(struct pxa_i2c *i2c)
>                         dev_dbg(&i2c->adap.dev, "%s: %ld: ISR=3D%08x, ICR=
=3D%08x, IBMR=3D%02x\n",
>                                 __func__, (long)jiffies, readl(_ISR(i2c))=
, readl(_ICR(i2c)), readl(_IBMR(i2c)));
>
> -               if ((readl(_ISR(i2c)) & (ISR_UB|ISR_IBB)) =3D=3D 0 ||
> +               if ((readl(_ISR(i2c)) & i2c->busy_mask) =3D=3D 0 ||
>                     (readl(_ISR(i2c)) & ISR_SAD) !=3D 0 ||
>                     (readl(_ICR(i2c)) & ICR_SCLE) =3D=3D 0) {
>                         if (i2c_debug > 1)
> @@ -1177,7 +1179,7 @@ static int i2c_pxa_pio_set_master(struct pxa_i2c *i=
2c)
>         /*
>          * Wait for the bus to become free.
>          */
> -       while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_UB))
> +       while (timeout-- && readl(_ISR(i2c)) & i2c->busy_mask)
>                 udelay(1000);
>
>         if (timeout < 0) {
> @@ -1322,7 +1324,7 @@ static void i2c_pxa_unprepare_recovery(struct i2c_a=
dapter *adap)
>          * handing control of the bus back to avoid the bus changing stat=
e.
>          */
>         isr =3D readl(_ISR(i2c));
> -       if (isr & (ISR_UB | ISR_IBB)) {
> +       if (isr & i2c->busy_mask) {
>                 dev_dbg(&i2c->adap.dev,
>                         "recovery: resetting controller, ISR=3D0x%08x\n",=
 isr);
>                 i2c_pxa_do_reset(i2c);
> @@ -1479,6 +1481,10 @@ static int i2c_pxa_probe(struct platform_device *d=
ev)
>         i2c->fm_mask =3D pxa_reg_layout[i2c_type].fm;
>         i2c->hs_mask =3D pxa_reg_layout[i2c_type].hs;
>
> +       i2c->busy_mask =3D ISR_UB | ISR_IBB;
> +       if (i2c_type =3D=3D REGS_A3700)
> +               i2c->busy_mask |=3D ISR_A3700_EBB;
> +
>         if (i2c_type !=3D REGS_CE4100)
>                 i2c->reg_isar =3D i2c->reg_base + pxa_reg_layout[i2c_type=
].isar;
>
>
> --
> 2.50.1
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
