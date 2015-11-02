From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/5] i2c-piix4: Convert piix4_main_adapter to array
Date: Mon, 02 Nov 2015 13:55:52 +0200
Message-ID: <1446465352.6332.85.camel@linux.intel.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
	 <1446395529-9987-3-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7856 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576AbbKBLzy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 06:55:54 -0500
In-Reply-To: <1446395529-9987-3-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com

On Sun, 2015-11-01 at 17:32 +0100, Christian Fetzer wrote:
> The SB800 chipset supports a multiplexed main SMBus controller with
> four ports. Therefore the static variable piix4_main_adapter is
> converted into a piix4_main_adapters array that can hold one
> i2c_adapter for each multiplexed port.
>=20
> The auxiliary adapter remains unchanged since it represents the
> second
> (not multiplexed) SMBus controller on the SB800 chipset.


> @@ -675,9 +678,14 @@ static void piix4_adap_remove(struct i2c_adapter
> *adap, int free_smba)
> =C2=A0
> =C2=A0static void piix4_remove(struct pci_dev *dev)
> =C2=A0{
> -	if (piix4_main_adapter) {
> -		piix4_adap_remove(piix4_main_adapter, 1);
> -		piix4_main_adapter =3D NULL;
> +	int port;
> +
> +	for (port =3D PIIX4_MAX_ADAPTERS - 1; port >=3D 0; port--) {
> +		if (piix4_main_adapters[port]) {
> +			piix4_adap_remove(piix4_main_adapters[port],
> +					=C2=A0=C2=A0port =3D=3D 0);
> +			piix4_main_adapters[port] =3D NULL;
> +		}
> =C2=A0	}

Would it be

int port =3D PIIX4_MAX_ADAPTERS;

while (--port) {
=C2=A0if (=E2=80=A6) {=E2=80=A6}
}

?

--=C2=A0
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
