--------------------------------------------------------------------------------
-- Quanty input file generated using Crispy.
--
-- elements: 3d transition metals
-- symmetry: Oh
-- experiment: RIXS
-- edge: L2,3-M4,5 (2p3d)
-- Hamiltonian: Coulomb, spin-orbit coupling, crystal field
-- transition operators: dipole-in, dipole-out
--------------------------------------------------------------------------------
Verbosity(0x00FF)

--------------------------------------------------------------------------------
-- Define the number of electrons, shells, etc.
--------------------------------------------------------------------------------
NBosons = 0
NFermions = 16

NElectrons_2p = $NElectrons_2p
NElectrons_3d = $NElectrons_3d

IndexDn_2p = {0, 2, 4}
IndexUp_2p = {1, 3, 5}
IndexDn_3d = {6, 8, 10, 12, 14}
IndexUp_3d = {7, 9, 11, 13, 15}

--------------------------------------------------------------------------------
-- Define the Coulomb term.
--------------------------------------------------------------------------------
OppF0_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {1, 0, 0})
OppF2_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 1, 0})
OppF4_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 0, 1})

OppF0_2p_3d = NewOperator('U', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {1, 0}, {0, 0})
OppF2_2p_3d = NewOperator('U', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {0, 1}, {0, 0})
OppG1_2p_3d = NewOperator('U', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {0, 0}, {1, 0})
OppG3_2p_3d = NewOperator('U', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {0, 0}, {0, 1})

Delta_sc    = $Delta_sc
U_3d_3d_sc  = $U(3d,3d)_sc
F2_3d_3d_sc = $F2(3d,3d)_sc
F4_3d_3d_sc = $F4(3d,3d)_sc
F0_3d_3d_sc = U_3d_3d_sc + 2 / 63 * F2_3d_3d_sc + 2 / 63 * F4_3d_3d_sc

Delta_ic    = $Delta_ic
U_3d_3d_ic  = $U(3d,3d)_ic
F2_3d_3d_ic = $F2(3d,3d)_ic
F4_3d_3d_ic = $F4(3d,3d)_ic
F0_3d_3d_ic = U_3d_3d_ic + 2 / 63 * F2_3d_3d_ic + 2 / 63 * F4_3d_3d_ic
U_2p_3d_ic  = $U(2p,3d)_ic
F2_2p_3d_ic = $F2(2p,3d)_ic
G1_2p_3d_ic = $G1(2p,3d)_ic
G3_2p_3d_ic = $G3(2p,3d)_ic
F0_2p_3d_ic = U_2p_3d_ic + 1 / 15 * G1_2p_3d_ic + 3 / 70 * G3_2p_3d_ic

Delta_fc    = $Delta_fc
U_3d_3d_fc  = $U(3d,3d)_fc
F2_3d_3d_fc = $F2(3d,3d)_fc
F4_3d_3d_fc = $F4(3d,3d)_fc
F0_3d_3d_fc = U_3d_3d_fc + 2 / 63 * F2_3d_3d_fc + 2 / 63 * F4_3d_3d_fc

H_coulomb_sc = F0_3d_3d_sc * OppF0_3d_3d
             + F2_3d_3d_sc * OppF2_3d_3d
             + F4_3d_3d_sc * OppF4_3d_3d

H_coulomb_ic = F0_3d_3d_ic * OppF0_3d_3d
             + F2_3d_3d_ic * OppF2_3d_3d
             + F4_3d_3d_ic * OppF4_3d_3d
             + F0_2p_3d_ic * OppF0_2p_3d
             + F2_2p_3d_ic * OppF2_2p_3d
             + G1_2p_3d_ic * OppG1_2p_3d
             + G3_2p_3d_ic * OppG3_2p_3d

H_coulomb_fc = F0_3d_3d_fc * OppF0_3d_3d
             + F2_3d_3d_fc * OppF2_3d_3d
             + F4_3d_3d_fc * OppF4_3d_3d

--------------------------------------------------------------------------------
-- Define the spin-orbit coupling term.
--------------------------------------------------------------------------------
Oppldots_3d = NewOperator('ldots', NFermions, IndexUp_3d, IndexDn_3d)

Oppldots_2p = NewOperator('ldots', NFermions, IndexUp_2p, IndexDn_2p)

zeta_3d_sc = $zeta(3d)_sc

zeta_3d_ic = $zeta(3d)_ic
zeta_2p_ic = $zeta(2p)_ic

zeta_3d_fc = $zeta(3d)_fc

H_soc_sc = zeta_3d_sc * Oppldots_3d

H_soc_ic = zeta_3d_ic * Oppldots_3d
         + zeta_2p_ic * Oppldots_2p

H_soc_fc = zeta_3d_fc * Oppldots_3d

--------------------------------------------------------------------------------
-- Define the crystal field term.
--------------------------------------------------------------------------------
OpptenDq = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {0.6, -0.4}))

tenDq_sc = $10Dq_sc

tenDq_ic = $10Dq_ic

tenDq_fc = $10Dq_fc

H_cf_sc = tenDq_sc * OpptenDq

H_cf_ic = tenDq_sc * OpptenDq

H_cf_fc = tenDq_fc * OpptenDq

--------------------------------------------------------------------------------
-- Define the magnetic field term.
--------------------------------------------------------------------------------
OppSx    = NewOperator('Sx'   , NFermions, IndexUp_3d, IndexDn_3d)
OppSy    = NewOperator('Sy'   , NFermions, IndexUp_3d, IndexDn_3d)
OppSz    = NewOperator('Sz'   , NFermions, IndexUp_3d, IndexDn_3d)
OppSsqr  = NewOperator('Ssqr' , NFermions, IndexUp_3d, IndexDn_3d)
OppSplus = NewOperator('Splus', NFermions, IndexUp_3d, IndexDn_3d)
OppSmin  = NewOperator('Smin' , NFermions, IndexUp_3d, IndexDn_3d)

OppLx    = NewOperator('Lx'   , NFermions, IndexUp_3d, IndexDn_3d)
OppLy    = NewOperator('Ly'   , NFermions, IndexUp_3d, IndexDn_3d)
OppLz    = NewOperator('Lz'   , NFermions, IndexUp_3d, IndexDn_3d)
OppLsqr  = NewOperator('Lsqr' , NFermions, IndexUp_3d, IndexDn_3d)
OppLplus = NewOperator('Lplus', NFermions, IndexUp_3d, IndexDn_3d)
OppLmin  = NewOperator('Lmin' , NFermions, IndexUp_3d, IndexDn_3d)

OppJx    = NewOperator('Jx'   , NFermions, IndexUp_3d, IndexDn_3d)
OppJy    = NewOperator('Jy'   , NFermions, IndexUp_3d, IndexDn_3d)
OppJz    = NewOperator('Jz'   , NFermions, IndexUp_3d, IndexDn_3d)
OppJsqr  = NewOperator('Jsqr' , NFermions, IndexUp_3d, IndexDn_3d)
OppJplus = NewOperator('Jplus', NFermions, IndexUp_3d, IndexDn_3d)
OppJmin  = NewOperator('Jmin' , NFermions, IndexUp_3d, IndexDn_3d)

Bx = $Bx * EnergyUnits.Tesla.value
By = $By * EnergyUnits.Tesla.value
Bz = $Bz * EnergyUnits.Tesla.value

B = Bx * (2 * OppSx + OppLx)
  + By * (2 * OppSy + OppLy)
  + Bz * (2 * OppSz + OppLz)

--------------------------------------------------------------------------------
-- Compose the total Hamiltonian.
--------------------------------------------------------------------------------
H_sc = $H_coulomb_flag * H_coulomb_sc + $H_soc_flag * H_soc_sc + $H_cf_flag * H_cf_sc + B
H_ic = $H_coulomb_flag * H_coulomb_ic + $H_soc_flag * H_soc_ic + $H_cf_flag * H_cf_ic + B
H_fc = $H_coulomb_flag * H_coulomb_fc + $H_soc_flag * H_soc_fc + $H_cf_flag * H_cf_fc + B

--------------------------------------------------------------------------------
-- Define the starting restrictions and set the number of initial states.
--------------------------------------------------------------------------------
StartingRestrictions = {NFermions, NBosons, {'111111 0000000000', NElectrons_2p, NElectrons_2p},
                                            {'000000 1111111111', NElectrons_3d, NElectrons_3d}}

NPsis = $NPsis

Psis = Eigensystem(H_sc, StartingRestrictions, NPsis)
if not (type(Psis) == 'table') then
    Psis = {Psis}
end

-- Print some useful information about the calculated states.
OppList = {H_sc, OppSsqr, OppLsqr, OppJsqr, OppSz, OppLz}

print('     <E>    <S^2>    <L^2>    <J^2>    <Sz>     <Lz>');
for key, Psi in pairs(Psis) do
	expectationValues = Psi * OppList * Psi
	for key, expectationValue in pairs(expectationValues) do
		io.write(string.format('%9.4f', Complex.Re(expectationValue)))
	end
	io.write('\n')
end

--------------------------------------------------------------------------------
-- Define the transition operators.
--------------------------------------------------------------------------------
t = math.sqrt(1/2);

OppTx_2p_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_2p, IndexDn_2p, {{1, -1, t    }, {1, 1, -t    }})
OppTy_2p_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_2p, IndexDn_2p, {{1, -1, t * I}, {1, 1,  t * I}})
OppTz_2p_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_2p, IndexDn_2p, {{1,  0, 1    }                })
OppTr_2p_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_2p, IndexDn_2p, {{1, -1, 1    }                })
OppTl_2p_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_2p, IndexDn_2p, {{1,  1, 1    }                })

OppTx_3d_2p = NewOperator('CF', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {{1, -1, t    }, {1, 1, -t    }})
OppTy_3d_2p = NewOperator('CF', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {{1, -1, t * I}, {1, 1,  t * I}})
OppTz_3d_2p = NewOperator('CF', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {{1,  0, 1    }                })
OppTr_3d_2p = NewOperator('CF', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {{1, -1, 1    }                })
OppTl_3d_2p = NewOperator('CF', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {{1,  1, 1    }                })

--------------------------------------------------------------------------------
-- Calculate and save the spectra.
--------------------------------------------------------------------------------
-- Define the temperature.
T = $T * EnergyUnits.Kelvin.value

-- Initialize the partition function and the spectrum.
Z = 0
G = 0

Emin1 = $Emin1
Emax1 = $Emax1
Gamma1 = $Gamma1
NE1 = $NE1

Emin2 = $Emin2
Emax2 = $Emax2
Gamma2 = $Gamma2
NE2 = $NE2

-- Calculate the ground state energy.
E_gs = Psis[1] * H_sc * Psis[1]

for j = 1, NPsis do
    E_j = Psis[j] * H_sc * Psis[j]

    if math.abs(E_j - E_gs) < 1e-12 then
        dZ = 1
    else
        dZ = math.exp(-(E_j - E_gs) / T)
    end

    if (dZ < 1e-8) then
        break
    end

    Z = Z + dZ

    G = G + CreateResonantSpectra(H_ic, H_fc, OppTx_2p_3d, OppTx_3d_2p, Psis[j], {{"Emin1", Emin1}, {"Emax1", Emax1}, {"NE1", NE1}, {"Gamma1", Gamma1}, {"Emin2", Emin2}, {"Emax2", Emax2}, {"NE2", NE2}, {"Gamma2", Gamma2}})
    G = G + CreateResonantSpectra(H_ic, H_fc, OppTx_2p_3d, OppTy_3d_2p, Psis[j], {{"Emin1", Emin1}, {"Emax1", Emax1}, {"NE1", NE1}, {"Gamma1", Gamma1}, {"Emin2", Emin2}, {"Emax2", Emax2}, {"NE2", NE2}, {"Gamma2", Gamma2}})
    G = G + CreateResonantSpectra(H_ic, H_fc, OppTx_2p_3d, OppTz_3d_2p, Psis[j], {{"Emin1", Emin1}, {"Emax1", Emax1}, {"NE1", NE1}, {"Gamma1", Gamma1}, {"Emin2", Emin2}, {"Emax2", Emax2}, {"NE2", NE2}, {"Gamma2", Gamma2}})

    G = G + CreateResonantSpectra(H_ic, H_fc, OppTy_2p_3d, OppTx_3d_2p, Psis[j], {{"Emin1", Emin1}, {"Emax1", Emax1}, {"NE1", NE1}, {"Gamma1", Gamma1}, {"Emin2", Emin2}, {"Emax2", Emax2}, {"NE2", NE2}, {"Gamma2", Gamma2}})
    G = G + CreateResonantSpectra(H_ic, H_fc, OppTy_2p_3d, OppTy_3d_2p, Psis[j], {{"Emin1", Emin1}, {"Emax1", Emax1}, {"NE1", NE1}, {"Gamma1", Gamma1}, {"Emin2", Emin2}, {"Emax2", Emax2}, {"NE2", NE2}, {"Gamma2", Gamma2}})
    G = G + CreateResonantSpectra(H_ic, H_fc, OppTy_2p_3d, OppTz_3d_2p, Psis[j], {{"Emin1", Emin1}, {"Emax1", Emax1}, {"NE1", NE1}, {"Gamma1", Gamma1}, {"Emin2", Emin2}, {"Emax2", Emax2}, {"NE2", NE2}, {"Gamma2", Gamma2}})

    G = G + CreateResonantSpectra(H_ic, H_fc, OppTz_2p_3d, OppTx_3d_2p, Psis[j], {{"Emin1", Emin1}, {"Emax1", Emax1}, {"NE1", NE1}, {"Gamma1", Gamma1}, {"Emin2", Emin2}, {"Emax2", Emax2}, {"NE2", NE2}, {"Gamma2", Gamma2}})
    G = G + CreateResonantSpectra(H_ic, H_fc, OppTz_2p_3d, OppTy_3d_2p, Psis[j], {{"Emin1", Emin1}, {"Emax1", Emax1}, {"NE1", NE1}, {"Gamma1", Gamma1}, {"Emin2", Emin2}, {"Emax2", Emax2}, {"NE2", NE2}, {"Gamma2", Gamma2}})
    G = G + CreateResonantSpectra(H_ic, H_fc, OppTz_2p_3d, OppTz_3d_2p, Psis[j], {{"Emin1", Emin1}, {"Emax1", Emax1}, {"NE1", NE1}, {"Gamma1", Gamma1}, {"Emin2", Emin2}, {"Emax2", Emax2}, {"NE2", NE2}, {"Gamma2", Gamma2}})
end

G = G / Z
G.Print({{'file', '$baseName' .. '.spec'}})
