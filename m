From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 06/19] i2c: octeon: Improve error status checking
Date: Wed, 13 Apr 2016 10:55:20 +0200
Message-ID: <20160413085519.GF1563@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <dded382de33f6a4b64c87d8ca2e016871403784d.1460387640.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dded382de33f6a4b64c87d8ca2e016871403784d.1460387640.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Please have a look at Documentation/i2c/fault-codes. -EAGAIN is only for
arbitration loss.

> +	/* ACK allowed on pre-terminal bytes only */
> +	case STAT_RXDATA_ACK:
> +		if (!final_read)
> +			return 0;
> +		return -EAGAIN;
> +
> +	/* NAK allowed on terminal byte only */
> +	case STAT_RXDATA_NAK:
> +		if (final_read)
> +			return 0;
> +		return -EAGAIN;

-EIO? Can this happen? It is the master who sends the NAK, so we are in
control of that.

> +
> +	/* Arbitration lost */
> +	case STAT_LOST_ARB_38:
> +	case STAT_LOST_ARB_68:
> +	case STAT_LOST_ARB_78:
> +	case STAT_LOST_ARB_B0:
> +		return -EAGAIN;

OK.

> +
> +	/* Being addressed as slave, should back off & listen */
> +	case STAT_SLAVE_60:
> +	case STAT_SLAVE_70:
> +	case STAT_GENDATA_ACK:
> +	case STAT_GENDATA_NAK:
> +		return -EIO;

-EOPNOTSUPP?

> +
> +	/* Core busy as slave */
> +	case STAT_SLAVE_80:
> +	case STAT_SLAVE_88:
> +	case STAT_SLAVE_A0:
> +	case STAT_SLAVE_A8:
> +	case STAT_SLAVE_LOST:
> +	case STAT_SLAVE_NAK:
> +	case STAT_SLAVE_ACK:
> +		return -EIO;

-EOPNOTSUPP?

> +	case STAT_TXDATA_NAK:

-EIO?

> +	case STAT_TXADDR_NAK:
> +	case STAT_RXADDR_NAK:
> +	case STAT_AD2W_NAK:

-ENXIO?

> +		return -EAGAIN;
> +	default:
> +		dev_err(i2c->dev, "unhandled state: %d\n", stat);
> +		return -EIO;

OK.


--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDgl3AAoJEBQN5MwUoCm2VHkP/3DkN/TZz6bFVcw4m2HA6y2C
eIChc9pXq3Hn7IO4ViMi42RPVCr7rMsZKO6D9REylVY9A2UeYEivhoJYc9V7ttD+
hwWVwcoe+k+Von5dG/HalKleylJae5rFtfVulyY7wIepFXGcnaJPVNBDsBd0jNtz
k3Pc4UmL/4wbyKgGFgi8l1FEADUZl5RWdejsP4dSidBjdx5rW8lq85h3514ulj+8
8Z//6qm1kvwzTGdB7qpwvR+9s6A/JlHEcpZ0V78sTz7Znao/No3GSvR4RPHrcdz3
nzcQtqb9XQBf+8CZUdYJIpMPNnyLIamN9ynAs1VgWd1Be94wz4UU0vSgRwsc1BCX
rqHuTEruQIc6fB9c3B0YaulKrB5uBp7GmRovj3aoF8fiCCXjyWWFanKxtVwsGzIN
p1KDFiYoDzp6MRGahwJZmEhei1B+OWVIGoQxv+Qg6oxrgix8q7GLSJ/VMTjzGHmi
vyb3QLjBox6oBlHBdW+Ek02C9idcuIRv+kyqtpgtwdkPdusSoQ+zUpr8e8b2GMor
x3X4UEEWNAIzoxa5wV5b1p3I6xs0GKjh0Cyw6i9JCNtlLhwQnnctmJ4gxErtgyTa
xvZTAagH9OqS5DKNrhVsx8TkkhOHiMRwKYHVjfRCyVo0/SHvnmOaEWijMzUXvfMg
kCcIGTko9fQZ+WakHT94
=8Q/i
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
