--------------------------------------------------------------------------------
-- Quanty input file generated using Crispy. If you use this file please cite
-- the following reference: http://dx.doi.org/10.5281/zenodo.1008184.
--
-- elements: 3d
-- symmetry: Oh
-- experiment: XES
-- edge: Kb (1s3p)
--------------------------------------------------------------------------------
Verbosity($Verbosity)

--------------------------------------------------------------------------------
-- Initialize the Hamiltonians.
--------------------------------------------------------------------------------
H_i = 0
H_m = 0
H_f = 0

--------------------------------------------------------------------------------
-- Toggle the Hamiltonian terms.
--------------------------------------------------------------------------------
H_atomic = $H_atomic
H_crystal_field = $H_crystal_field
H_3d_ligands_hybridization_lmct = $H_3d_ligands_hybridization_lmct
H_magnetic_field = $H_magnetic_field
H_exchange_field = $H_exchange_field

--------------------------------------------------------------------------------
-- Define the number of electrons, shells, etc.
--------------------------------------------------------------------------------
NBosons = 0
NFermions = 18

NElectrons_1s = 2
NElectrons_3p = 6
NElectrons_3d = $NElectrons_3d

IndexDn_1s = {0}
IndexUp_1s = {1}
IndexDn_3p = {2, 4, 6}
IndexUp_3p = {3, 5, 7}
IndexDn_3d = {8, 10, 12, 14, 16}
IndexUp_3d = {9, 11, 13, 15, 17}

if H_3d_ligands_hybridization_lmct == 1 then
    NFermions = 28

    NElectrons_L1 = 10

    IndexDn_L1 = {18, 20, 22, 24, 26}
    IndexUp_L1 = {19, 21, 23, 25, 27}
end

if H_3d_ligands_hybridization_mlct == 1 then
    NFermions = 28

    NElectrons_L2 = 0

    IndexDn_L2 = {18, 20, 22, 24, 26}
    IndexUp_L2 = {19, 21, 23, 25, 27}
end

if H_3d_ligands_hybridization_lmct == 1 and H_3d_ligands_hybridization_mlct == 1 then
    return
end

--------------------------------------------------------------------------------
-- Define the atomic term.
--------------------------------------------------------------------------------
N_1s = NewOperator('Number', NFermions, IndexUp_1s, IndexUp_1s, {1})
     + NewOperator('Number', NFermions, IndexDn_1s, IndexDn_1s, {1})

N_3p = NewOperator('Number', NFermions, IndexUp_3p, IndexUp_3p, {1, 1, 1})
     + NewOperator('Number', NFermions, IndexDn_3p, IndexDn_3p, {1, 1, 1})

N_3d = NewOperator('Number', NFermions, IndexUp_3d, IndexUp_3d, {1, 1, 1, 1, 1})
     + NewOperator('Number', NFermions, IndexDn_3d, IndexDn_3d, {1, 1, 1, 1, 1})

if H_atomic == 1 then
    F0_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {1, 0, 0})
    F2_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 1, 0})
    F4_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 0, 1})

    F0_3p_3d = NewOperator('U', NFermions, IndexUp_3p, IndexDn_3p, IndexUp_3d, IndexDn_3d, {1, 0}, {0, 0})
    F2_3p_3d = NewOperator('U', NFermions, IndexUp_3p, IndexDn_3p, IndexUp_3d, IndexDn_3d, {0, 1}, {0, 0})
    G1_3p_3d = NewOperator('U', NFermions, IndexUp_3p, IndexDn_3p, IndexUp_3d, IndexDn_3d, {0, 0}, {1, 0})
    G3_3p_3d = NewOperator('U', NFermions, IndexUp_3p, IndexDn_3p, IndexUp_3d, IndexDn_3d, {0, 0}, {0, 1})

    F0_1s_3d = NewOperator('U', NFermions, IndexUp_1s, IndexDn_1s, IndexUp_3d, IndexDn_3d, {1}, {0})
    G2_1s_3d = NewOperator('U', NFermions, IndexUp_1s, IndexDn_1s, IndexUp_3d, IndexDn_3d, {0}, {1})

    U_3d_3d_i = $U(3d,3d)_i_value
    F2_3d_3d_i = $F2(3d,3d)_i_value * $F2(3d,3d)_i_scale
    F4_3d_3d_i = $F4(3d,3d)_i_value * $F4(3d,3d)_i_scale
    F0_3d_3d_i = U_3d_3d_i + 2 / 63 * F2_3d_3d_i + 2 / 63 * F4_3d_3d_i

    U_3d_3d_m = $U(3d,3d)_m_value
    F2_3d_3d_m = $F2(3d,3d)_m_value * $F2(3d,3d)_m_scale
    F4_3d_3d_m = $F4(3d,3d)_m_value * $F4(3d,3d)_m_scale
    F0_3d_3d_m = U_3d_3d_m + 2 / 63 * F2_3d_3d_m + 2 / 63 * F4_3d_3d_m
    U_1s_3d_m = $U(1s,3d)_m_value
    G2_1s_3d_m = $G2(1s,3d)_m_value * $G2(1s,3d)_m_scale
    F0_1s_3d_m = U_1s_3d_m + 1 / 10 * G2_1s_3d_m

    U_3d_3d_f = $U(3d,3d)_f_value
    F2_3d_3d_f = $F2(3d,3d)_f_value * $F2(3d,3d)_f_scale
    F4_3d_3d_f = $F4(3d,3d)_f_value * $F4(3d,3d)_f_scale
    F0_3d_3d_f = U_3d_3d_f + 2 / 63 * F2_3d_3d_f + 2 / 63 * F4_3d_3d_f
    U_3p_3d_f = $U(3p,3d)_f_value
    F2_3p_3d_f = $F2(3p,3d)_f_value * $F2(3p,3d)_f_scale
    G1_3p_3d_f = $G1(3p,3d)_f_value * $G1(3p,3d)_f_scale
    G3_3p_3d_f = $G3(3p,3d)_f_value * $G3(3p,3d)_f_scale
    F0_3p_3d_f = U_3p_3d_f + 1 / 15 * G1_3p_3d_f + 3 / 70 * G3_3p_3d_f

    H_i = H_i + Chop(
          F0_3d_3d_i * F0_3d_3d
        + F2_3d_3d_i * F2_3d_3d
        + F4_3d_3d_i * F4_3d_3d)

    H_m = H_m + Chop(
          F0_3d_3d_m * F0_3d_3d
        + F2_3d_3d_m * F2_3d_3d
        + F4_3d_3d_m * F4_3d_3d
        + F0_1s_3d_m * F0_1s_3d
        + G2_1s_3d_m * G2_1s_3d)

    H_f = H_f + Chop(
          F0_3d_3d_f * F0_3d_3d
        + F2_3d_3d_f * F2_3d_3d
        + F4_3d_3d_f * F4_3d_3d
        + F0_3p_3d_f * F0_3p_3d
        + F2_3p_3d_f * F2_3p_3d
        + G1_3p_3d_f * G1_3p_3d
        + G3_3p_3d_f * G3_3p_3d)

    ldots_3d = NewOperator('ldots', NFermions, IndexUp_3d, IndexDn_3d)

    ldots_3p = NewOperator('ldots', NFermions, IndexUp_3p, IndexDn_3p)

    zeta_3d_i = $zeta(3d)_i_value * $zeta(3d)_i_scale

    zeta_3d_m = $zeta(3d)_m_value * $zeta(3d)_m_scale

    zeta_3d_f = $zeta(3d)_f_value * $zeta(3d)_f_scale
    zeta_3p_f = $zeta(3p)_f_value * $zeta(3p)_f_scale

    H_i = H_i + Chop(
          zeta_3d_i * ldots_3d)

    H_m = H_m + Chop(
          zeta_3d_m * ldots_3d)

    H_f = H_f + Chop(
          zeta_3d_f * ldots_3d
        + zeta_3p_f * ldots_3p)
end

--------------------------------------------------------------------------------
-- Define the crystal field term.
--------------------------------------------------------------------------------
if H_crystal_field == 1 then
    -- PotentialExpandedOnClm('Oh', 2, {Eeg, Et2g})
    -- tenDq_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {0.6, -0.4}))

    Akm = {{4, 0, 2.1}, {4, -4, 1.5 * sqrt(0.7)}, {4, 4, 1.5 * sqrt(0.7)}}
    tenDq_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, Akm)

    tenDq_3d_i = $10Dq(3d)_i_value

    io.write('Energies of the 3d orbitals in the initial Hamiltonian (crystal field term only):\n')
    io.write('================\n')
    io.write('Irrep.         E\n')
    io.write('================\n')
    io.write(string.format('eg      %8.3f\n',  0.6 * tenDq_3d_i))
    io.write(string.format('t2g     %8.3f\n', -0.4 * tenDq_3d_i))
    io.write('================\n')
    io.write('\n')

    tenDq_3d_m = $10Dq(3d)_m_value

    tenDq_3d_f = $10Dq(3d)_f_value

    H_i = H_i + Chop(
          tenDq_3d_i * tenDq_3d)

    H_m = H_m + Chop(
          tenDq_3d_m * tenDq_3d)

    H_f = H_f + Chop(
          tenDq_3d_f * tenDq_3d)
end

--------------------------------------------------------------------------------
-- Define the 3d-ligands hybridization term (LMCT).
--------------------------------------------------------------------------------
if H_3d_ligands_hybridization_lmct == 1 then
    N_L1 = NewOperator('Number', NFermions, IndexUp_L1, IndexUp_L1, {1, 1, 1, 1, 1})
         + NewOperator('Number', NFermions, IndexDn_L1, IndexDn_L1, {1, 1, 1, 1, 1})

    Delta_3d_L1_i = $Delta(3d,L1)_i_value
    e_3d_i = (10 * Delta_3d_L1_i - NElectrons_3d * (19 + NElectrons_3d) * U_3d_3d_i / 2) / (10 + NElectrons_3d)
    e_L1_i = NElectrons_3d * ((1 + NElectrons_3d) * U_3d_3d_i / 2 - Delta_3d_L1_i) / (10 + NElectrons_3d)

    Delta_3d_L1_m = $Delta(3d,L1)_m_value
    e_3d_m = (10 * Delta_3d_L1_m - NElectrons_3d * (23 + NElectrons_3d) * U_3d_3d_m / 2 - 22 * U_1s_3d_m) / (12 + NElectrons_3d)
    e_1s_m = (10 * Delta_3d_L1_m + (1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_m / 2 - (10 + NElectrons_3d) * U_1s_3d_m)) / (12 + NElectrons_3d)
    e_L1_m = ((1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_m / 2 + 2 * U_1s_3d_m) - (2 + NElectrons_3d) * Delta_3d_L1_m) / (12 + NElectrons_3d)

    Delta_3d_L1_f = $Delta(3d,L1)_f_value
    e_3d_f = (10 * Delta_3d_L1_f - NElectrons_3d * (31 + NElectrons_3d) * U_3d_3d_f / 2 - 90 * U_3p_3d_f) / (16 + NElectrons_3d)
    e_3p_f = (10 * Delta_3d_L1_f + (1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_f / 2 - (10 + NElectrons_3d) * U_3p_3d_f)) / (16 + NElectrons_3d)
    e_L1_f = ((1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_f / 2 + 6 * U_3p_3d_f) - (6 + NElectrons_3d) * Delta_3d_L1_f) / (16 + NElectrons_3d)

    H_i = H_i + Chop(
          e_3d_i * N_3d
        + e_L1_i * N_L1)

    H_m = H_m + Chop(
          e_3d_m * N_3d
        + e_1s_m * N_1s
        + e_L1_m * N_L1)

    H_f = H_f + Chop(
          e_3d_f * N_3d
        + e_3p_f * N_3p
        + e_L1_f * N_L1)

    tenDq_L1 = NewOperator('CF', NFermions, IndexUp_L1, IndexDn_L1, PotentialExpandedOnClm('Oh', 2, {0.6, -0.4}))

    Veg_3d_L1 = NewOperator('CF', NFermions, IndexUp_L1, IndexDn_L1, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {1, 0}))
              + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_L1, IndexDn_L1, PotentialExpandedOnClm('Oh', 2, {1, 0}))

    Vt2g_3d_L1 = NewOperator('CF', NFermions, IndexUp_L1, IndexDn_L1, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {0, 1}))
               + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_L1, IndexDn_L1, PotentialExpandedOnClm('Oh', 2, {0, 1}))

    tenDq_L1_i = $10Dq(L1)_i_value
    Veg_3d_L1_i = $Veg(3d,L1)_i_value
    Vt2g_3d_L1_i = $Vt2g(3d,L1)_i_value

    tenDq_L1_m = $10Dq(L1)_m_value
    Veg_3d_L1_m = $Veg(3d,L1)_m_value
    Vt2g_3d_L1_m = $Vt2g(3d,L1)_m_value

    tenDq_L1_f = $10Dq(L1)_f_value
    Veg_3d_L1_f = $Veg(3d,L1)_f_value
    Vt2g_3d_L1_f = $Vt2g(3d,L1)_f_value

    H_i = H_i + Chop(
          tenDq_L1_i * tenDq_L1
        + Veg_3d_L1_i * Veg_3d_L1
        + Vt2g_3d_L1_i * Vt2g_3d_L1)

    H_m = H_m + Chop(
          tenDq_L1_m * tenDq_L1
        + Veg_3d_L1_m * Veg_3d_L1
        + Vt2g_3d_L1_m * Vt2g_3d_L1)

    H_f = H_f + Chop(
          tenDq_L1_f * tenDq_L1
        + Veg_3d_L1_f * Veg_3d_L1
        + Vt2g_3d_L1_f * Vt2g_3d_L1)
end

--------------------------------------------------------------------------------
-- Define the 3d-ligands hybridization term (MLCT).
--------------------------------------------------------------------------------
if H_3d_ligands_hybridization_mlct == 1 then
    N_L2 = NewOperator('Number', NFermions, IndexUp_L2, IndexUp_L2, {1, 1, 1, 1, 1})
         + NewOperator('Number', NFermions, IndexDn_L2, IndexDn_L2, {1, 1, 1, 1, 1})

    Delta_3d_L2_i = $Delta(3d,L2)_i_value
    e_3d_i = U_3d_3d_i * (-NElectrons_3d + 1) / 2
    e_L2_i = Delta_3d_L2_i - U_3d_3d_i * NElectrons_3d / 2 - U_3d_3d_i / 2

    Delta_3d_L2_m = $Delta(3d,L2)_m_value
    e_3d_m = -(U_3d_3d_m * NElectrons_3d^2 + 3 * U_3d_3d_m * NElectrons_3d + 4 * U_1s_3d_m) / (2 * NElectrons_3d + 4)
    e_1s_m = NElectrons_3d * (U_3d_3d_m * NElectrons_3d + U_3d_3d_m - 2 * U_1s_3d_m * NElectrons_3d - 2 * U_1s_3d_m) / (2 * (NElectrons_3d + 2))
    e_L2_m = (2 * Delta_3d_L2_m * NElectrons_3d + 4 * Delta_3d_L2_m - U_3d_3d_m * NElectrons_3d^2 - U_3d_3d_m * NElectrons_3d - 4 * U_1s_3d_m * NElectrons_3d - 4 * U_1s_3d_m) / (2  *(NElectrons_3d + 2))

    Delta_3d_L2_f = $Delta(3d,L2)_f_value
    e_3d_f = -(U_3d_3d_f * NElectrons_3d^2 + 11 * U_3d_3d_f * NElectrons_3d + 60 * U_3p_3d_f) / (2 * NElectrons_3d + 12)
    e_3p_f = NElectrons_3d * (U_3d_3d_f * NElectrons_3d + U_3d_3d_f - 2 * U_3p_3d_f * NElectrons_3d - 2 * U_3p_3d_f) / (2 * (NElectrons_3d + 6))
    e_L2_f = (2 * Delta_3d_L2_f * NElectrons_3d + 12 * Delta_3d_L2_f - U_3d_3d_f * NElectrons_3d^2 - U_3d_3d_f * NElectrons_3d - 12 * U_3p_3d_f * NElectrons_3d - 12 * U_3p_3d_f) / (2 * (NElectrons_3d + 6))

    H_i = H_i + Chop(
          e_3d_i * N_3d
        + e_L2_i * N_L2)

    H_m = H_m + Chop(
          e_3d_m * N_3d
        + e_1s_m * N_1s
        + e_L2_m * N_L2)

    H_f = H_f + Chop(
          e_3d_f * N_3d
        + e_3p_f * N_3p
        + e_L2_f * N_L2)

    tenDq_L2 = NewOperator('CF', NFermions, IndexUp_L2, IndexDn_L2, PotentialExpandedOnClm('Oh', 2, {0.6, -0.4}))

    Veg_3d_L2 = NewOperator('CF', NFermions, IndexUp_L2, IndexDn_L2, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {1, 0}))
              + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_L2, IndexDn_L2, PotentialExpandedOnClm('Oh', 2, {1, 0}))

    Vt2g_3d_L2 = NewOperator('CF', NFermions, IndexUp_L2, IndexDn_L2, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {0, 1}))
               + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_L2, IndexDn_L2, PotentialExpandedOnClm('Oh', 2, {0, 1}))

    tenDq_L2_i = $10Dq(L2)_i_value
    Veg_3d_L2_i = $Veg(3d,L2)_i_value
    Vt2g_3d_L2_i = $Vt2g(3d,L2)_i_value

    tenDq_L2_m = $10Dq(L2)_m_value
    Veg_3d_L2_m = $Veg(3d,L2)_m_value
    Vt2g_3d_L2_m = $Vt2g(3d,L2)_m_value

    tenDq_L2_f = $10Dq(L2)_f_value
    Veg_3d_L2_f = $Veg(3d,L2)_f_value
    Vt2g_3d_L2_f = $Vt2g(3d,L2)_f_value

    H_i = H_i + Chop(
          tenDq_L2_i * tenDq_L2
        + Veg_3d_L2_i * Veg_3d_L2
        + Vt2g_3d_L2_i * Vt2g_3d_L2)

    H_m = H_m + Chop(
          tenDq_L2_m * tenDq_L2
        + Veg_3d_L2_m * Veg_3d_L2
        + Vt2g_3d_L2_m * Vt2g_3d_L2)

    H_f = H_f + Chop(
          tenDq_L2_f * tenDq_L2
        + Veg_3d_L2_f * Veg_3d_L2
        + Vt2g_3d_L2_f * Vt2g_3d_L2)
end

--------------------------------------------------------------------------------
-- Define the magnetic field and exchange field terms.
--------------------------------------------------------------------------------
Sx_3d = NewOperator('Sx', NFermions, IndexUp_3d, IndexDn_3d)
Sy_3d = NewOperator('Sy', NFermions, IndexUp_3d, IndexDn_3d)
Sz_3d = NewOperator('Sz', NFermions, IndexUp_3d, IndexDn_3d)
Ssqr_3d = NewOperator('Ssqr', NFermions, IndexUp_3d, IndexDn_3d)
Splus_3d = NewOperator('Splus', NFermions, IndexUp_3d, IndexDn_3d)
Smin_3d = NewOperator('Smin', NFermions, IndexUp_3d, IndexDn_3d)

Lx_3d = NewOperator('Lx', NFermions, IndexUp_3d, IndexDn_3d)
Ly_3d = NewOperator('Ly', NFermions, IndexUp_3d, IndexDn_3d)
Lz_3d = NewOperator('Lz', NFermions, IndexUp_3d, IndexDn_3d)
Lsqr_3d = NewOperator('Lsqr', NFermions, IndexUp_3d, IndexDn_3d)
Lplus_3d = NewOperator('Lplus', NFermions, IndexUp_3d, IndexDn_3d)
Lmin_3d = NewOperator('Lmin', NFermions, IndexUp_3d, IndexDn_3d)

Jx_3d = NewOperator('Jx', NFermions, IndexUp_3d, IndexDn_3d)
Jy_3d = NewOperator('Jy', NFermions, IndexUp_3d, IndexDn_3d)
Jz_3d = NewOperator('Jz', NFermions, IndexUp_3d, IndexDn_3d)
Jsqr_3d = NewOperator('Jsqr', NFermions, IndexUp_3d, IndexDn_3d)
Jplus_3d = NewOperator('Jplus', NFermions, IndexUp_3d, IndexDn_3d)
Jmin_3d = NewOperator('Jmin', NFermions, IndexUp_3d, IndexDn_3d)

Tx_3d = NewOperator('Tx', NFermions, IndexUp_3d, IndexDn_3d)
Ty_3d = NewOperator('Ty', NFermions, IndexUp_3d, IndexDn_3d)
Tz_3d = NewOperator('Tz', NFermions, IndexUp_3d, IndexDn_3d)

Sx = Sx_3d
Sy = Sy_3d
Sz = Sz_3d

Lx = Lx_3d
Ly = Ly_3d
Lz = Lz_3d

Jx = Jx_3d
Jy = Jy_3d
Jz = Jz_3d

Tx = Tx_3d
Ty = Ty_3d
Tz = Tz_3d

Ssqr = Sx * Sx + Sy * Sy + Sz * Sz
Lsqr = Lx * Lx + Ly * Ly + Lz * Lz
Jsqr = Jx * Jx + Jy * Jy + Jz * Jz

if H_magnetic_field == 1 then
    Bx_i = $Bx_i_value
    By_i = $By_i_value
    Bz_i = $Bz_i_value

    Bx_m = $Bx_m_value
    By_m = $By_m_value
    Bz_m = $Bz_m_value

    Bx_f = $Bx_f_value
    By_f = $By_f_value
    Bz_f = $Bz_f_value

    H_i = H_i + Chop(
          Bx_i * (2 * Sx + Lx)
        + By_i * (2 * Sy + Ly)
        + Bz_i * (2 * Sz + Lz))

    H_m = H_m + Chop(
          Bx_m * (2 * Sx + Lx)
        + By_m * (2 * Sy + Ly)
        + Bz_m * (2 * Sz + Lz))

    H_f = H_f + Chop(
          Bx_f * (2 * Sx + Lx)
        + By_f * (2 * Sy + Ly)
        + Bz_f * (2 * Sz + Lz))
end

if H_exchange_field == 1 then
    Hx_i = $Hx_i_value
    Hy_i = $Hy_i_value
    Hz_i = $Hz_i_value

    Hx_m = $Hx_m_value
    Hy_m = $Hy_m_value
    Hz_m = $Hz_m_value

    Hx_f = $Hx_f_value
    Hy_f = $Hy_f_value
    Hz_f = $Hz_f_value

    H_i = H_i + Chop(
          Hx_i * Sx
        + Hy_i * Sy
        + Hz_i * Sz)

    H_m = H_m + Chop(
          Hx_m * Sx
        + Hy_m * Sy
        + Hz_m * Sz)

    H_f = H_f + Chop(
          Hx_f * Sx
        + Hy_f * Sy
        + Hz_f * Sz)
end


NConfigurations = $NConfigurations

--------------------------------------------------------------------------------
-- Define the restrictions and set the number of initial states.
--------------------------------------------------------------------------------
InitialRestrictions = {NFermions, NBosons, {'11 000000 0000000000', NElectrons_1s, NElectrons_1s},
                                           {'00 111111 0000000000', NElectrons_3p, NElectrons_3p},
                                           {'00 000000 1111111111', NElectrons_3d, NElectrons_3d}}

IntermediateRestrictions = {NFermions, NBosons, {'11 000000 0000000000', NElectrons_1s - 1, NElectrons_1s - 1},
                                                {'00 111111 0000000000', NElectrons_3p, NElectrons_3p},
                                                {'00 000000 1111111111', NElectrons_3d, NElectrons_3d}}

FinalRestrictions = {NFermions, NBosons, {'11 000000 0000000000', NElectrons_1s, NElectrons_1s},
                                         {'00 111111 0000000000', NElectrons_3p - 1, NElectrons_3p - 1},
                                         {'00 000000 1111111111', NElectrons_3d, NElectrons_3d}}

if H_3d_ligands_hybridization_lmct == 1 then
    InitialRestrictions = {NFermions, NBosons, {'11 000000 0000000000 0000000000', NElectrons_1s, NElectrons_1s},
                                               {'00 111111 0000000000 0000000000', NElectrons_3p, NElectrons_3p},
                                               {'00 000000 1111111111 0000000000', NElectrons_3d, NElectrons_3d},
                                               {'00 000000 0000000000 1111111111', NElectrons_L1, NElectrons_L1}}

    IntermediateRestrictions = {NFermions, NBosons, {'11 000000 0000000000 0000000000', NElectrons_1s - 1, NElectrons_1s - 1},
                                                    {'00 111111 0000000000 0000000000', NElectrons_3p, NElectrons_3p},
                                                    {'00 000000 1111111111 0000000000', NElectrons_3d, NElectrons_3d},
                                                    {'00 000000 0000000000 1111111111', NElectrons_L1, NElectrons_L1}}

    FinalRestrictions = {NFermions, NBosons, {'11 000000 0000000000 0000000000', NElectrons_1s, NElectrons_1s},
                                             {'00 111111 0000000000 0000000000', NElectrons_3p - 1, NElectrons_3p - 1},
                                             {'00 000000 1111111111 0000000000', NElectrons_3d, NElectrons_3d},
                                             {'00 000000 0000000000 1111111111', NElectrons_L1, NElectrons_L1}}

    CalculationRestrictions = {NFermions, NBosons, {'00 000000 0000000000 1111111111', NElectrons_L1 - (NConfigurations - 1), NElectrons_L1}}
end

if H_3d_ligands_hybridization_mlct == 1 then
    InitialRestrictions = {NFermions, NBosons, {'11 000000 0000000000 0000000000', NElectrons_1s, NElectrons_1s},
                                               {'00 111111 0000000000 0000000000', NElectrons_3p, NElectrons_3p},
                                               {'00 000000 1111111111 0000000000', NElectrons_3d, NElectrons_3d},
                                               {'00 000000 0000000000 1111111111', NElectrons_L2, NElectrons_L2}}

    IntermediateRestrictions = {NFermions, NBosons, {'11 000000 0000000000 0000000000', NElectrons_1s - 1, NElectrons_1s - 1},
                                                    {'00 111111 0000000000 0000000000', NElectrons_3p, NElectrons_3p},
                                                    {'00 000000 1111111111 0000000000', NElectrons_3d, NElectrons_3d},
                                                    {'00 000000 0000000000 1111111111', NElectrons_L2, NElectrons_L2}}

    FinalRestrictions = {NFermions, NBosons, {'11 000000 0000000000 0000000000', NElectrons_1s, NElectrons_1s},
                                             {'00 111111 0000000000 0000000000', NElectrons_3p - 1, NElectrons_3p - 1},
                                             {'00 000000 1111111111 0000000000', NElectrons_3d, NElectrons_3d},
                                             {'00 000000 0000000000 1111111111', NElectrons_L2, NElectrons_L2}}

    CalculationRestrictions = {NFermions, NBosons, {'00 000000 0000000000 1111111111', NElectrons_L2, NElectrons_L2 + (NConfigurations - 1)}}
end

T = $T * EnergyUnits.Kelvin.value

-- Approximate machine epsilon for single precision arithmetics.
epsilon = 1.19e-07

NPsis = $NPsis
NPsisAuto = $NPsisAuto

dZ = {}

if NPsisAuto == 1 and NPsis ~= 1 then
    NPsis = 4
    NPsisIncrement = 8
    NPsisIsConverged = false

    while not NPsisIsConverged do
        if CalculationRestrictions == nil then
            Psis_i = Eigensystem(H_i, InitialRestrictions, NPsis)
        else
            Psis_i = Eigensystem(H_i, InitialRestrictions, NPsis, {{'restrictions', CalculationRestrictions}})
        end

        if not (type(Psis_i) == 'table') then
            Psis_i = {Psis_i}
        end

        E_gs_i = Psis_i[1] * H_i * Psis_i[1]

        Z = 0

        for i, Psi in ipairs(Psis_i) do
            E = Psi * H_i * Psi

            if math.abs(E - E_gs_i) < epsilon then
                dZ[i] = 1
            else
                dZ[i] = math.exp(-(E - E_gs_i) / T)
            end

            Z = Z + dZ[i]

            if (dZ[i] / Z) < math.sqrt(epsilon) then
                i = i - 1
                NPsisIsConverged = true
                NPsis = i
                Psis_i = {unpack(Psis_i, 1, i)}
                dZ = {unpack(dZ, 1, i)}
                break
            end
        end

        if NPsisIsConverged then
            break
        else
            NPsis = NPsis + NPsisIncrement
        end
    end
else
    if CalculationRestrictions == nil then
        Psis_i = Eigensystem(H_i, InitialRestrictions, NPsis)
    else
        Psis_i = Eigensystem(H_i, InitialRestrictions, NPsis, {{'restrictions', CalculationRestrictions}})
    end

    if not (type(Psis_i) == 'table') then
        Psis_i = {Psis_i}
    end
        E_gs_i = Psis_i[1] * H_i * Psis_i[1]

    Z = 0

    for i, Psi in ipairs(Psis_i) do
        E = Psi * H_i * Psi

        if math.abs(E - E_gs_i) < epsilon then
            dZ[i] = 1
        else
            dZ[i] = math.exp(-(E - E_gs_i) / T)
        end

        Z = Z + dZ[i]
    end
end

-- Normalize dZ to unity.
for i in ipairs(dZ) do
    dZ[i] = dZ[i] / Z
end

--------------------------------------------------------------------------------
-- Define the transition operators.
--------------------------------------------------------------------------------
t = math.sqrt(1/2)

Tu_1s = NewOperator('An', NFermions, IndexUp_1s[1])
Td_1s = NewOperator('An', NFermions, IndexDn_1s[1])

Tx_3p_1s = NewOperator('CF', NFermions, IndexUp_1s, IndexDn_1s, IndexUp_3p, IndexDn_3p, {{1, -1, t    }, {1, 1, -t    }})
Ty_3p_1s = NewOperator('CF', NFermions, IndexUp_1s, IndexDn_1s, IndexUp_3p, IndexDn_3p, {{1, -1, t * I}, {1, 1,  t * I}})
Tz_3p_1s = NewOperator('CF', NFermions, IndexUp_1s, IndexDn_1s, IndexUp_3p, IndexDn_3p, {{1,  0, 1    }                })

k = $k1

-- List with the user selected spectra.
spectra = {$spectra}

--------------------------------------------------------------------------------
-- Calculate and save the spectrum.
--------------------------------------------------------------------------------
Sk = Chop(k[1] * Sx + k[2] * Sy + k[3] * Sz)
Lk = Chop(k[1] * Lx + k[2] * Ly + k[3] * Lz)
Jk = Chop(k[1] * Jx + k[2] * Jy + k[3] * Jz)
Tk = Chop(k[1] * Tx + k[2] * Ty + k[3] * Tz)

Operators = {H_i, Ssqr, Lsqr, Jsqr, Sk, Lk, Jk, Tk, ldots_3d, N_1s, N_3d, 'dZ'}
header = 'Analysis of the initial Hamiltonian:\n'
header = header .. '=================================================================================================================================\n'
header = header .. 'State         <E>     <S^2>     <L^2>     <J^2>      <Sk>      <Lk>      <Jk>      <Tk>     <l.s>    <N_1s>    <N_3d>          dZ\n'
header = header .. '=================================================================================================================================\n'
footer = '=================================================================================================================================\n'

if H_3d_ligands_hybridization_lmct == 1 then
    Operators = {H_i, Ssqr, Lsqr, Jsqr, Sk, Lk, Jk, Tk, ldots_3d, N_1s, N_3d, N_L1, 'dZ'}
    header = 'Analysis of the initial Hamiltonian:\n'
    header = header .. '===========================================================================================================================================\n'
    header = header .. 'State         <E>     <S^2>     <L^2>     <J^2>      <Sk>      <Lk>      <Jk>      <Tk>     <l.s>    <N_1s>    <N_3d>    <N_L1>          dZ\n'
    header = header .. '===========================================================================================================================================\n'
    footer = '===========================================================================================================================================\n'
end

if H_3d_ligands_hybridization_mlct == 1 then
    Operators = {H_i, Ssqr, Lsqr, Jsqr, Sk, Lk, Jk, Tk, ldots_3d, N_1s, N_3d, N_L2, 'dZ'}
    header = 'Analysis of the initial Hamiltonian:\n'
    header = header .. '===========================================================================================================================================\n'
    header = header .. 'State         <E>     <S^2>     <L^2>     <J^2>      <Sk>      <Lk>      <Jk>      <Tk>     <l.s>    <N_1s>    <N_3d>    <N_L2>          dZ\n'
    header = header .. '===========================================================================================================================================\n'
    footer = '===========================================================================================================================================\n'
end

io.write(header)
for i, Psi in ipairs(Psis_i) do
    io.write(string.format('%5d', i))
    for j, Operator in ipairs(Operators) do
        if j == 1 then
            io.write(string.format('%12.6f', Complex.Re(Psi * Operator * Psi)))
        elseif Operator == 'dZ' then
            io.write(string.format('%12.2E', dZ[i]))
        else
            io.write(string.format('%10.4f', Complex.Re(Psi * Operator * Psi)))
        end
    end
    io.write('\n')
end
io.write(footer)


if next(spectra) == nil then
    return
end

E_gs_i = Psis_i[1] * H_i * Psis_i[1]

-- if CalculationRestrictions == nil then
--     Psis_m = Eigensystem(H_m, IntermediateRestrictions, 1)
-- else
--     Psis_m = Eigensystem(H_m, IntermediateRestrictions, 1, {{'restrictions', CalculationRestrictions}})
-- end
-- Psis_m = {Psis_m}
-- E_gs_m = Psis_m[1] * H_m * Psis_m[1]

if CalculationRestrictions == nil then
    Psis_f = Eigensystem(H_f, FinalRestrictions, 1)
else
    Psis_f = Eigensystem(H_f, FinalRestrictions, 1, {{'restrictions', CalculationRestrictions}})
end
Psis_f = {Psis_f}
E_gs_f = Psis_f[1] * H_f * Psis_f[1]

Eedge1 = 0
DeltaE1 = 0

Eedge2 = $Eedge1
DeltaE2 = E_gs_f - E_gs_i

Emin1 = -20
Emax1 = 40
NE1 = 1
Gamma1 = 0

Emin2 = ($Emin1 - Eedge2) + DeltaE2
Emax2 = ($Emax1 - Eedge2) + DeltaE2
NE2 = $NE1
Gamma2 = $Gamma1

DenseBorder = $DenseBorder

G = 0

if CalculationRestrictions == nil then
    G = G + CreateResonantSpectra(H_m, H_f, {Tu_1s, Td_1s}, {Tx_3p_1s, Ty_3p_1s, Tz_3p_1s}, Psis_i, {{'Emin1', Emin1}, {'Emax1', Emax1}, {'NE1', NE1}, {'Gamma1', Gamma1}, {'Emin2', Emin2}, {'Emax2', Emax2}, {'NE2', NE2}, {'Gamma2', Gamma2}, {'DenseBorder', DenseBorder}})
else
    G = G + CreateResonantSpectra(H_m, H_f, {Tu_1s, Td_1s}, {Tx_3p_1s, Ty_3p_1s, Tz_3p_1s}, Psis_i, {{'Emin1', Emin1}, {'Emax1', Emax1}, {'NE1', NE1}, {'Gamma1', Gamma1}, {'Emin2', Emin2}, {'Emax2', Emax2}, {'NE2', NE2}, {'Gamma2', Gamma2}, {'restrictions1', CalculationRestrictions}, {'restrictions2', CalculationRestrictions}, {'DenseBorder', DenseBorder}})
end

Giso = 0
shift = 0

for i = 1, #Psis_i do
    for j = 1, 3 * 2 do
        Indexes = {}
        for k = 1, NE1 + 1 do
            table.insert(Indexes, k + shift)
        end
        Giso = Giso + Spectra.Element(G, Indexes) * dZ[i]
        shift = shift + NE1 + 1
    end
end

Giso = -1 * Giso

Giso.Print({{'file', '$BaseName_iso.spec'}})

