From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Wed, 6 Jul 2016 15:55:24 +0900
Message-ID: <20160706065523.GA1439@tetsubishi>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51769 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbcGFGzl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 6 Jul 2016 02:55:41 -0400
Content-Disposition: inline
In-Reply-To: <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 07:57:07PM -0700, Viresh Kumar wrote:
> The i2c-dev calls i2c_get_adapter() from the .open() callback, which
> doesn't let the adapter device unregister unless the .close() callback
> is called.
>=20
> On some platforms (like Google ARA), this doesn't let the modules
> (hardware attached to the phone) eject from the phone as the cleanup
> path for the module hasn't finished yet (i2c adapter not removed).
>=20
> We can't let the userspace block the kernel forever in such cases.
>=20
> Fix this by calling i2c_get_adapter() from all other file operations,
> i.e.  read/write/ioctl, to make sure the adapter doesn't get away while
> we are in the middle of a operation, but not otherwise. In .open() we
> will release the adapter device before returning and so if there is no
> data transfer in progress, then the i2c-dev doesn't block the adapter
> from unregistering.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I'd think Jean has more experience with I2C hotplugging approaches and
difficulties, so I'd be interested in his high level review.

However:

> @@ -234,6 +234,7 @@ struct i2c_client {
>  	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
>  	struct device dev;		/* the device structure		*/
>  	int irq;			/* irq issued by device		*/
> +	int adapter_nr;
>  	struct list_head detected;

Adding something to *every* i2c_client for this corner case sounds
pretty expensive to me.

Regards,

   Wolfram


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfKtbAAoJEBQN5MwUoCm2CmUQAJna9j9Kd7wRGxJLU6B6LW1w
TVAG7RYqby0Q9pe0Uxo+z8s7bUsDs7stXsD5uV6bJIO6fBQdEFCzdyPdcoaB4h2y
wnOJFEpUzmIsOBZEjmfMnvN7fXokgQR8QnTag6LofiGJmoYkT85cvJ1yzIel71LX
N3dFSZiDWAlW5dlNiQnIuU9EN0cLQ5A4sINvG5MlXt+rEdc6veMlwKtQDP3BzXQ9
su/Hjo6dmWdTnmnG+LwFbZCbR+CxGOtjJzD7ye1ujoQjHSZXDpilzcUbKxYUHOW7
9SdbzPc6IrKW3BLiMMuFU1R+MYWNFKlkJTk0IgJEM8V6d99j8yVkrzgZIGJzlrdT
P1UNHSqIhATlqX9CET8wOqDo3awo3ZDPNaPk4gxcqJVIG2YX4iLnHtmu1jVyJsyl
NWEFRR2rGNdwtz0zwSpZaL41hWNWNHVvoMo/j3rMxoYLkmjikr8Z7II4CcX7zJ5y
he400v41fOvSR+YR5W6SmlNdOXz1jbFC9iXN/VnqAxBNp3hj7PWbs2hyKslsgmKJ
oKUQuQNe+PowuJZFkbswfCRRQ/7zmhYM1eujkYmqfPWSnhhjBPbWyWKTVaCV6tes
MHXMP7vwzC2W9Nn67b4FdH2bth1+I0LRnc2M2P3R+Wvy69W1AkFRSuWX3/w7lioU
bWDLMYopSvRx7nj54FlZ
=3Das
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
