From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v4 4/6] usb: dwc3: qcom: Add support for booting with ACPI
Date: Mon, 17 Jun 2019 15:32:07 +0300
Message-ID: <87y320gzp4.fsf@linux.intel.com>
References: <20190612142654.9639-1-lee.jones@linaro.org> <20190612142654.9639-5-lee.jones@linaro.org> <20190617102146.GG16364@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617102146.GG16364@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Lee Jones <lee.jones@linaro.org> writes:
>> In Linux, the DWC3 core exists as its own independent platform device.
>> Thus when describing relationships in Device Tree, the current default
>> boot configuration table option, the DWC3 core often resides as a child
>> of the platform specific node.  Both of which are given their own
>> address space descriptions and the drivers can be mostly agnostic to
>> each other.
>>=20
>> However, other Operating Systems have taken a more monolithic approach,
>> which is evident in the configuration ACPI tables for the Qualcomm
>> Snapdragon SDM850, where all DWC3 (core and platform) components are
>> described under a single IO memory region.
>>=20
>> To ensure successful booting using the supplied ACPI tables, we need to
>> devise a way to chop up the address regions provided and subsequently
>> register the DWC3 core with the resultant information, which is
>> precisely what this patch aims to achieve.
>>=20
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>  drivers/usb/dwc3/Kconfig     |   2 +-
>>  drivers/usb/dwc3/dwc3-qcom.c | 206 ++++++++++++++++++++++++++++++-----
>>  2 files changed, 179 insertions(+), 29 deletions(-)
>
> I'm starting to get a little twitchy about these patches now.  Due to
> the release cadence of the larger Linux distros, it's pretty important
> that these changes land in v5.3.  Without them, it is impossible to
> install Linux on some pretty high profile emerging platforms.
>
> It's already -rc5 and I'm concerned that we're going to miss the
> merge-window.  Would you be kind enough to review these patches
> please?  The Pinctrl and I2C parts of the set have already been
> merged.

I don't seem to have this series in my inbox. This is the only email I
have in this series.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0HiEkACgkQzL64meEa
mQZgTg/+MvWLo+0fVFNR04KSqTX6nZcqLk/4KwBc7uy1RsD4WMFa3zcKE/jB8scd
KN48Szwr6TxXj6/nboP7PeKF+u2ftbYw8L1Ggtd1Okq/Fn8mUcM+vY1xGotjgrao
ZXbOLcI393gCADUuEgHbOZDXPeLtgF2K/RQ06CPJ+wPunpx3pDwJVaMumW5Inocu
Yz/eMkd5XP2QXDfL8F+27ZfnZQ6oNbEa+RV0cakbyvjHWDbkeiCW2DN5YFM3gJpC
T9RXeqzKIUkfWd3mLcBq54Z3wCh51nw2UfThE1bQK2XlPKPXnU9P/Oi7ZIJYn5X4
hF9PoBRoYWoaS5v9TJxL+78F+salna/FVsr6jKtbmVQjr4t3H+2i3SKXUmcMtaP9
/jXg8jRCni44640ri7F4xN52TdkE/K7eAShOTp2izyRydKkZRxCOgW0xPh1Yi6Yx
DGFxy4TQPUc6uAchzWfB/DIQywLYMDChFGMc525vTiw3ATnWf5dK7c/G0FufNs+g
YcXsD9HyhYs9puAp4DBUZmXZGiuPHT8Se78aTfYqAvY7oFH5puh2Mg8UDLeeiatr
A67I1jpWh9RvTGFPpBABobbaItB4lMcitFy2MqxByxNmJt9l5bbExTRmdXLFzbZK
db8+BiVaO0xw70s0j9BuGwO/YolXOiX2i4lP4Qzhc7WjniL3FPw=
=l8qE
-----END PGP SIGNATURE-----
--=-=-=--
